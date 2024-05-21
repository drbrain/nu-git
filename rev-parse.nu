use options.nu [
  exclude_hidden
]

# Parse objects
export def main [] {
  error make -u {
    msg: "You must use a subcommand"
  }
}

def abbrev [] {
  [
    [value description];

    [loose "Do not warn for ambiguous names"]
    [strict "Warn if the name you passed is ambiguous"]
  ]
}

def rev_parse [
  args
] {
  run-external "git" "rev-parse" ...$args
}

export def objects [
  ...objects: string                      # Objects to parse
  --abbrev-ref                            # A non-ambiguous short name of the object's name
  --abbrev-ref: string@abbrev             # A non-ambiguous short name of the object's name
  --all                                   # Return all refs found
  --branches                              # Return all branches
  --branches: string                      # Return all branches matching this pattern
  --disambiguate: string                  # Return all objects starting with this prefix
  --exclude-hidden: string@exclude_hidden # Do not include refs that would be hidden by the given command
  --exclude: string                       # Exclude refs matching this glob
  --glob: string                          # Return all refs matching this glob
  --not                                   # Prefix object names with ^
  --remotes                               # Return all remotes
  --remotes: string                       # Return all remotes matching this pattern
  --symbolic                              # Output names as close to the original input as possible
  --symbolic-full-name                    # --symbolic, but show full names for non-refs
  --tags                                  # Return all tags
  --tags: string                          # Return all tags matching this pattern
] {
  mut args = []

  if $symbolic { $args = ( $args | append "--symbolic" ) }
  if $symbolic_full_name { $args = ( $args | append "--symbolic-full-name" ) }

  if $abbrev_ref == true {
    $args = ( $args | append "--abbrev-ref" )
  } else if $abbrev_ref != null {
    $args = ( $args | append [ "--abbrev-ref" $abbrev_ref ])
  }
  if $all { $args = ( $args | append "--all" ) }
  if $branches == true {
    $args = ( $args | append "--branches" )
  } else if $branches != null {
    $args = ( $args | append [ "--branches" $branches ])
  }
  if $disambiguate != null { $args = ( $args | append [ "--disambiguate" $disambiguate ]) }
  if $exclude != null { $args = ( $args | append [ "--exclude" $exclude ]) }
  if $exclude_hidden != null { $args = ( $args | append [ "--exclude-hidden" $exclude_hidden ]) }
  if $glob != null { $args = ( $args | append [ "--glob" $glob ]) }
  if $not { $args = ( $args | append "--not" ) }
  if $remotes == true {
    $args = ( $args | append "--remotes" )
  } else if $remotes != null {
    $args = ( $args | append [ "--remotes" $remotes ])
  }
  if $tags == true {
    $args = ( $args | append "--tags" )
  } else if $tags != null {
    $args = ( $args | append [ "--tags" $tags ])
  }

  let args = $args | append $objects

  rev_parse $args
}

# List GIT_ environment variables local to the repository
export def local-env-vars [] {
  run-external "git" "rev-parse" "--local-env-vars"
  | lines
}

def path_format [] {
  [
    [value description];

    [absolute "Return an absolute directory"]
    [relative "Return a directory relative to the current working directory"]
  ]
}

# Show $GIT_DIR or the path to the .git directory
export def git-dir [
  --path-format: string@path_format # Set the path format
] {
  mut args = []
  if $path_format != null { $args = ( $args | append $"--path-format=($path_format)" ) }

  let args = $args | append "--git-dir"

  rev_parse $args
  | into string
  | str trim
}

# Show $GIT_COMMON_DIR if defined, else $GIT_DIR
export def git-common-dir [
  --path-format: string@path_format # Set the path format
] {
  mut args = []
  if $path_format != null { $args = ( $args | append $"--path-format=($path_format)" ) }

  let args = $args | append "--git-common-dir"

  rev_parse $args
  | into string
  | str trim
}

# Resolve an entry in $GIT_DIR accounting for relocation variables
export def git-path [
  path: path                        # Path to resolve
  --path-format: string@path_format # Set the path format
] {
  mut args = []
  if $path_format != null { $args = ( $args | append $"--path-format=($path_format)" ) }

  let args = $args | append [ "--git-path" $path ]

  rev_parse $args
  | into string
  | str trim
}

# Check if a path is a valid repository or a gitfile that points at a repository
export def resolve-git-dir [
  dir: path                         # Path to check
  --path-format: string@path_format # Set the path format
] {
  mut args = []
  if $path_format != null { $args = ( $args | append $"--path-format=($path_format)" ) }

  let args = $args | append [ "--resolve-git-dir" $dir ]

  rev_parse $args
  | into string
  | str trim
}

# Show the path to the shared index file in split index mode
export def shared-path-index [
  --path-format: string@path_format # Set the path format
] {
  mut args = []
  if $path_format != null { $args = ( $args | append $"--path-format=($path_format)" ) }

  let args = $args | append "--shared-path-index"

  rev_parse $args
  | into string
  | str trim
}

# Show the root of the superproject's working tree
export def show-superproject-working-tree [
  --path-format: string@path_format # Set the path format
] {
  mut args = []
  if $path_format != null { $args = ( $args | append $"--path-format=($path_format)" ) }

  let args = $args | append "--show-superproject-working-tree"

  rev_parse $args
  | into string
  | str trim
}

# Show the path of the top-level directory of the working tree
export def show-toplevel [
  --path-format: string@path_format # Set the path format
] {
  mut args = []
  if $path_format != null { $args = ( $args | append $"--path-format=($path_format)" ) }

  let args = $args | append "--show-toplevel"

  rev_parse $args
  | into string
  | str trim
}

# git rev-parse git-dir with an absolute path
export def absolute-git-dir [] {
  rev_parse "--absolute-git-dir"
  | into string
  | str trim
}

# Print true if the repository is bare
export def is-bare-repository [] {
  rev_parse "--is-bare-repository"
  | into bool
}

# Return true if the working directory is inside a repository directory
export def is-inside-git-dir [] {
  rev_parse "--is-inside-git-dir"
  | into bool
}

# Return true if the working directory is inside the repository work tree
export def is-inside-work-tree [] {
  rev_parse "--is-inside-work-tree"
  | into bool
}

# Return true if the repository is shallow
export def is-shallow-repository [] {
  rev_parse "--is-shallow-repository"
  | into bool
}

# Return the path to the top-level directory from the current directory
export def show-cdup [] {
  rev_parse "--show-cdup"
  | into string
  | str trim
}

# Return the path of the current directory relative to the top-level directory
export def show-prefix [] {
  rev_parse "--show-prefix"
  | into string
  | str trim
}

def object_format [] {
  [
    [value description];

    [storage "git directory object format"]
    [input   "input object format"]
    [output  "output object format"]
  ]
}

# Return the object format for storage inside the .git directory
export def show-object-format [
  format?: string@object_format # Set the path format
] {
  let args = if $format == null {
    "--show-object-format"
  } else {
    $"--show-object-format=($format)"
  }

  let result = rev_parse $args
  | into string
  | str trim

  if $format == input {
    $result
    | split row " "
  } else {
    $result
  }
}

# Verify the parameter matches an object
export def verify [
  ...args: string      # Arguments to verify
  --not                # Prefix object names with ^
  --short              # Shorten the object name
  --short: number      # Shorten the object name to this length
  --symbolic           # Output names as close to the original input as possible
  --symbolic-full-name # --symbolic, but show full names for non-refs
] {
  mut args = []

  if $not { $args = ( $args | append "--not" ) }
  if $symbolic { $args = ( $args | append "--symbolic" ) }
  if $symbolic_full_name { $args = ( $args | append "--symbolic-full-name" ) }

  let args = $args | append $args

  rev_parse $args
  | into string
  | str trim
}

# TODO: split into --parseopt and --sq-quote
