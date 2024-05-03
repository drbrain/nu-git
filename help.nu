export def comp_commands [] {
  run-external "git" "help" "--all"
  | help_to_table
  | rename value description
}

def help_to_table [] {
  $in
  | lines
  | where $it =~ "^   "
  | str trim
  | parse -r '(?<item>[\w-]+)\s+(?<description>.*)'
  | flatten
  | sort
}
# Display help for a git command
#
# If a command name overlaps with a subcommand use `git help man $item`
export extern main [
  item: string@comp_commands # Item to show help for
] {
  run-external git help "--man" $item
}

export def commands [
  --no-external-commands # Exclude external git-* commands in your PATH
  --no-aliases # Exclude configured aliases
] {
  mut args = [ "--all" ]

  if $no_external_commands { $args = ( $args | append "--no-external-commands" ) }
  if $no_aliases { $args = ( $args | append "--no-aliases" ) }

  let args = $args

  run-external "git" "help" $args
  | help_to_table
  | rename command description
}

# List configuration variables
export def config [] {
  run-external git help "--config"
  | lines
  | drop 2
}

# Show developer interfaces
export def "developer-interfaces" [] {
  run-external git help "--developer-interfaces"
  | help_to_table
  | rename interface description
}

# Show git concept guides
export def guides [] {
  run-external git help "--guides"
  | help_to_table
  | rename guide description
}

# Show a info page for a command or document
export def info [
  item: string@comp_commands # Item to show an info page for
] {
  run-external git help "--info" $item
}

# Show a man page for a command or document
export def man [
  item: string@comp_commands # Item to show a man page for
] {
  run-external git help "--man" $item
}

# Show user interfaces
export def "user-interfaces" [] {
  run-external git help "--user-interfaces"
  | help_to_table
  | rename interface description
}

# Show a web page for a command or document
export def web [
  item: string@comp_commands # Item to show a web page for
] {
  run-external git help "--web" $item
}

