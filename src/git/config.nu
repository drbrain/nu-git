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

# Get and set repository or global options
export extern "git config" [
  name: string
  value?: any
  value_pattern?: any
  --replace-all              # Replace all matching lines
  --add                      # Add a new line without altering exitsing values
  --get                      # Get the value for a key
  --get-all                  # Get all values for a multi-value key
  --get-regexp               # Get values matching a regexp
  --get-urlmatch: string     # Get a value by URL match
  --global                   # Use user .gitconfig
  --system                   # Use system .gitconfig
  --local                    # Use repository .gitconfig
  --worktree                 # Use worktree .gitconfig
  --file(-f): string         # Use named git config
  --blob: string             # Read from a blob
  --remove-section           # Remove a remove a section
  --rename-section           # Rename a section
  --unset                    # Remove a line
  --unset-all                # Remove all lines
  --list(-l)                 # List set variables and values
  --fixed-value              # Match exactly
  --type: string@config_type # Validate value type
  --no-type                  # Unset type validation
  --null(-z)                 # End output values with a NUL
  --name-only                # Output only names
  --show-origin              # Show config value origin file
  --show-scope               # Show config value origin scope
  --get-colorbool: string    # Output bool if color should be used
  --get-color: string        # Retrive a color with a default
  --edit(-e)                 # Modifiy configuration in an editor
  --includes                 # Respect includes when looking up values
  --no-includes              # Ignore includes when looking up values
  --default                  # Default value when using --get
  --help                     # Show help
]

