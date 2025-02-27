def names [
  context: string
] {
  let config = if not ( $context | parse -r '--global' | is-empty ) {
    "--global"
  } else if not ( $context | parse -r '--system' | is-empty ) {
    "--system"
  } else if not ( $context | parse -r '--local' | is-empty ) {
    "--local"
  } else if not ( $context | parse -r '--worktree' | is-empty ) {
    "--worktree"
  } else if not ( $context | parse -r '--file' | is-empty ) {
    let file = $context | parse -r '\s--file\s+(?<file>[^\s]+)'
    [ "--file" $file ]
  } else if not ( $context | parse -r '-f' | is-empty ) {
    let file = $context | parse -r '\s-file\s+(?<file>[^\s]+)'
    [ "--file" $file ]
  } else if not ( $context | parse -r '--blob' | is-empty ) {
    let blob = $context | parse -r '\s--blob\s+(?<blob>[^\s]+)'
    [ "--blob" $blob ]
  }

  let args = [
    "--list"
    "--name-only"
    "--show-origin"
    "--show-scope"
  ]
  | append $config

  let complete = $context
  | parse -r '\s(?<final>[^\s]+)$'
  | get final.0

  run-external "git" "config" ...$args
  | lines
  | parse "{origin}\t{scope}\t{value}"
  | where value =~ $"^($complete)"
  | upsert description {|r|
    let s = $r.scope
    | parse -r '(?<source>[^:]+):(?<scope>.*)'

    $"($r.origin) \(($s.source.0) ($s.scope.0)\)"
  }
  | select value description
  | sort-by value
}

def config_type [] {
  [
    { value: "bool", description: "true or false" },
    { value: "bool-or-int", description: "bool or int" },
    { value: "color", description: "Expressible as an ANSI color" },
    { value: "expiry-date", description: "Fixed or relative date" },
    { value: "int", description: "Decimal number with an optional k, m, g suffix" },
    { value: "path", description: "Path to a file" },
  ]
}

def is_tty [] {
  [
    { value: "true", description: "Is a tty" },
    { value: "false", description: "Is not a tty" },
  ]
}

def option_default [
  args: list<string>
  default
] {
  mut args = $args

  if $default != null {
    $args = ( $args | append [ "--default" $default ])
  }

  $args
}

# This can generate invalid arguments, we'll let git take care of that
def option_file [
  global: bool,
  system: bool,
  local: bool,
  worktree: bool,
  file,
  blob,
] {
  mut args = []

  if $global { $args = ( $args | append "--global" ) }
  if $system { $args = ( $args | append "--system" ) }
  if $local { $args = ( $args | append "--local" ) }
  if $worktree { $args = ( $args | append "--worktree" ) }

  if $file != null { $args = ( $args | append [ "--file" $file ] ) }
  if $blob != null { $args = ( $args | append [ "--blob" $blob ] ) }

  $args
}

def option_fixed_value [
  args: list<string>
  fixed_value: bool
] {
  mut args = $args

  if $fixed_value {
    $args | append "--fixed-value"
  } else {
    $args
  }
}

def option_includes [
  args: list<string>
  includes: bool
  no_includes: bool
] {
  mut args = $args

  if $includes { $args = ( $args | append "--includes" ) }
  if $no_includes { $args = ( $args | append "--no-includes" ) }

  $args
}

def option_null [
  args: list<string>
  null: bool
] {
  mut args = $args

  if $null {
    $args | append "--null"
  } else {
    $args
  }
}

def option_show [
  args: list<string>
  origin: bool
  scope: bool
] {
  mut args = $args

  if $origin { $args = ( $args | append "--show-origin" ) }
  if $scope { $args = ( $args | append "--show-scope" ) }

  $args
}

def option_type [
  args: list<string>
  type
  no_type
] {
  mut args = $args

  if $type != null { $args = ( $args | append [ "--type" $type ] ) }
  if $no_type { $args = ( $args | append "--no-type" ) }

  $args
}

# TODO: support show-origin and show-scope
def result_to_output [
  null: bool
  show_origin: bool
  show_scope: bool
  record: bool
] {
  if $null and $record {
    error make {
      msg: "--record not allowed with --null"
    }
  } else if $null {
    $in
  } else if $record {
    $in
    | result_to_record
  } else {
    $in
    | result_to_list
  }
}

def result_to_list [] {
  $in
  | split row "\u{0}"
  | parse -r '^(?<key>[^\n]+)(?:\n(?<value>.*))?'
  | reduce --fold {} {|entry, result|
    $result
    | upsert $entry.key {||
      $entry.value
    }
  }
}

def result_to_record [] {
  $in
  | split row "\u{0}"
  | parse -r '^(?<key>[^\n]+)(?:\n(?<value>.*))?'
  | reduce --fold {} {|entry, result|
    $result
    | upsert ( $entry.key | split row '.' | into cell-path ) {||
      $entry.value
    }
  }
}

# Get and set repository or global options
export def main [] {
  help git config
}

# Add a new line to the option without altering existing values
export def add [
  --global                   # Use user .gitconfig
  --system                   # Use system .gitconfig
  --local                    # Use repository .gitconfig (default)
  --worktree                 # Use worktree .gitconfig
  --file(-f): path           # Use named git config
  --blob: string             # Read config from a blob object
  --type: string@config_type # Validate value type
  --no-type                  # Unset type validation
  name: string               # Name of value to add
  value: string              # Value to add
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_type $args $type $no_type
  let args = $args | append [ $name $value ]

  run-external "git" "config" "--add" ...$args
}

# Open a config file in your editor
export def edit [
  --global         # Use user .gitconfig
  --system         # Use system .gitconfig
  --local          # Use repository .gitconfig (default)
  --worktree       # Use worktree .gitconfig
  --file(-f): path # Use named git config
  --blob: string   # Read config from a blob object
] {
  let args = option_file $global $system $local $worktree $file $blob

  run-external "git" "config" "--edit" ...$args
}

# Get a value for a key
export def get [
  --global                   # Use user .gitconfig
  --system                   # Use system .gitconfig
  --local                    # Use repository .gitconfig (default)
  --worktree                 # Use worktree .gitconfig
  --file(-f): path           # Use named git config
  --blob: string             # Read config from a blob object
  --includes                 # Respect includes
  --no-includes              # Ignore includes
  --type: string@config_type # Validate value type
  --no-type                  # Unset type validation
  --show-origin              # Show config value origin file
  --show-scope               # Show config value origin scope
  --null(-z)                 # End output values with a NUL
  --fixed-value              # Match <value_pattern> exactly
  --default: string          # Default value
  name: string@names         # Name of value to get
  value_pattern?: string     # Pattern of values to get
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_includes $args $includes $no_includes
  let args = option_type $args $type $no_type
  let args = option_show $args $show_origin $show_scope
  let args = option_fixed_value $args $fixed_value
  let args = option_null $args $null
  let args = option_default $args $default
  let args = $args | append [ $name $value_pattern ] | compact

  run-external "git" "config" "--get" ...$args
}

# Get all values for a multi-value key
export def "get-all" [
  --global                   # Use user .gitconfig
  --system                   # Use system .gitconfig
  --local                    # Use repository .gitconfig (default)
  --worktree                 # Use worktree .gitconfig
  --file(-f): path           # Use named git config
  --blob: string             # Read config from a blob object
  --includes                 # Respect includes
  --no-includes              # Ignore includes
  --type: string@config_type # Validate value type
  --no-type                  # Unset type validation
  --show-origin              # Show config value origin file
  --show-scope               # Show config value origin scope
  --null(-z)                 # End output values with a NUL
  --fixed-value              # Match <value_pattern> exactly
  name: string@names         # Name of value to get
  value_pattern?: string     # Pattern of values to get
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_includes $args $includes $no_includes
  let args = option_type $args $type $no_type
  let args = option_show $args $show_origin $show_scope
  let args = option_null $args $null
  let args = option_fixed_value $args $fixed_value
  let args = $args | append [ $name $value_pattern ] | compact

  run-external "git" "config" "--get-all" ...$args
}

# Get a color as an ANSI color sequence
export def "get-color" [
  --global           # Use user .gitconfig
  --system           # Use system .gitconfig
  --local            # Use repository .gitconfig (default)
  --worktree         # Use worktree .gitconfig
  --file(-f): path   # Use named git config
  --blob: string     # Read config from a blob object
  --includes         # Respect includes
  --no-includes      # Ignore includes
  --default: string  # Default color value
  name: string@names # Name of color to get
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_includes $args $includes $no_includes
  let args = option_default $args $default
  let args = $args | append $name

  run-external "git" "config" "--get-color" ...$args
}

# Get a color and output "true" or "false"
export def "get-colorbool" [
  --global                      # Use user .gitconfig
  --system                      # Use system .gitconfig
  --local                       # Use repository .gitconfig (default)
  --worktree                    # Use worktree .gitconfig
  --file(-f): path              # Use named git config
  --blob: string                # Read config from a blob object
  --includes                    # Respect includes
  --no-includes                 # Ignore includes
  name: string@names            # Name of color to get
  stdout_is_tty?: string@is_tty # Override checking if stdout is a TTY
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_includes $args $includes $no_includes
  let args = $args | append [ $name $stdout_is_tty ] | compact

  run-external "git" "config" "--get-colorbool" ...$args
}

# Get keys that match a regular expression
export def "get-regexp" [
  --global                   # Use user .gitconfig
  --system                   # Use system .gitconfig
  --local                    # Use repository .gitconfig (default)
  --worktree                 # Use worktree .gitconfig
  --file(-f): path           # Use named git config
  --blob: string             # Read config from a blob object
  --includes                 # Respect includes
  --no-includes              # Ignore includes
  --type: string@config_type # Validate value type
  --no-type                  # Unset type validation
  --show-origin              # Show config value origin file
  --show-scope               # Show config value origin scope
  --null(-z)                 # End output values with a NUL
  --fixed-value              # Match <value_pattern> exactly
  --record                   # Output as a record
  name_regex: string         # Pattern of names to get
  value_pattern?: string     # Pattern of values to get
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_includes $args $includes $no_includes
  let args = option_type $args $type $no_type
  let args = option_show $args $show_origin $show_scope
  let args = option_fixed_value $args $fixed_value
  let args = $args | append [ $name_regex $value_pattern ] | compact

  run-external "git" "config" "--get-regexp" "--null" ...$args
  | result_to_output $null $show_origin $show_scope $record
}

# Get keys that have a matching URL as a component
export def "get-urlmatch" [
  --global                   # Use user .gitconfig
  --system                   # Use system .gitconfig
  --local                    # Use repository .gitconfig (default)
  --worktree                 # Use worktree .gitconfig
  --file(-f): path           # Use named git config
  --blob: string             # Read config from a blob object
  --includes                 # Respect includes
  --no-includes              # Ignore includes
  --type: string@config_type # Validate value type
  --no-type                  # Unset type validation
  --null(-z)                 # End output values with a NUL
  --record                   # Output as a record
  name: string@names         # Name of value to add
  url: string                # URL to match
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_includes $args $includes $no_includes
  let args = option_type $args $type $no_type
  let args = option_null $args $null
  let args = $args | append [ $name $url ]

  run-external "git" "config" "--get-urlmatch" ...$args
  | result_to_output $null false false $record
}

# List all variables and values
export def list [
  --global         # Use user .gitconfig
  --system         # Use system .gitconfig
  --local          # Use repository .gitconfig (default)
  --worktree       # Use worktree .gitconfig
  --file(-f): path # Use named git config
  --blob: string   # Read config from a blob object
  --show-origin    # Show config value origin file
  --show-scope     # Show config value origin scope
  --null(-z)       # End output values with a NUL
  --name-only      # Output only names
  --record         # Output as a record
] {
  let args = option_file $global $system $local $worktree $file $blob
  mut args = option_show $args $show_origin $show_scope

  if $name_only { $args = ( $args | append "--name-only" ) }

  run-external "git" "config" "--list" "--null" ...$args
  | result_to_output $null false false $record
}

# Remove a section
export def "remove-section" [
  --global           # Use user .gitconfig
  --system           # Use system .gitconfig
  --local            # Use repository .gitconfig (default)
  --worktree         # Use worktree .gitconfig
  --file(-f): path   # Use named git config
  --blob: string     # Read config from a blob object
  name: string@names # Section to remove
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = $args | append $name

  run-external "git" "config" "--remove-section" ...$args
}

# Rename a section
export def "rename-section" [
  --global               # Use user .gitconfig
  --system               # Use system .gitconfig
  --local                # Use repository .gitconfig (default)
  --worktree             # Use worktree .gitconfig
  --file(-f): path       # Use named git config
  --blob: string         # Read config from a blob object
  old_name: string@names # Old section name
  new_name: string       # New section name
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = $args | append [ $old_name $new_name ]

  run-external "git" "config" "--rename-section" ...$args
}

# Replace all lines matching a name
export def "replace-all" [
  --global                   # Use user .gitconfig
  --system                   # Use system .gitconfig
  --local                    # Use repository .gitconfig (default)
  --worktree                 # Use worktree .gitconfig
  --file(-f): path           # Use named git config
  --blob: string             # Read config from a blob object
  --type: string@config_type # Validate value type
  --no-type                  # Unset type validation
  --fixed-value              # Match <value_pattern> exactly
  name: string@names         # Name of value to add
  value: string              # Value to add
  value_pattern?: string     # Pattern of values to replace
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_type $args $type $no_type
  let args = option_fixed_value $args $fixed_value
  let args = $args | append [ $name $value_pattern ] | compact

  run-external "git" "config" "--replace-all" ...$args
}

# Remove a line matching a key
export def "unset" [
  --global               # Use user .gitconfig
  --system               # Use system .gitconfig
  --local                # Use repository .gitconfig (default)
  --worktree             # Use worktree .gitconfig
  --file(-f): path       # Use named git config
  --blob: string         # Read config from a blob object
  --fixed-value          # Match <value_pattern> exactly
  name: string@names     # Name of value to unset
  value_pattern?: string # Pattern of values to unset
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_fixed_value $args $fixed_value
  let args = $args | append [ $name $value_pattern ] | compact

  run-external "git" "config" "--unset" ...$args
}

# Remove all matching lines
export def "unset-all" [
  --global               # Use user .gitconfig
  --system               # Use system .gitconfig
  --local                # Use repository .gitconfig (default)
  --worktree             # Use worktree .gitconfig
  --file(-f): path       # Use named git config
  --blob: string         # Read config from a blob object
  --fixed-value          # Match <value_pattern> exactly
  name: string@names     # Name of value to unset
  value_pattern?: string # Pattern of values to unset
] {
  let args = option_file $global $system $local $worktree $file $blob
  let args = option_fixed_value $args $fixed_value
  let args = $args | append [ $name $value_pattern ] | compact

  run-external "git" "config" "--unset-all" ...$args
}

