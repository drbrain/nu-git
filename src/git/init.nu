# Create or reinitialize a git repository
export extern "git init" [
  directory: path              # Directory to create a git repository in
  --quiet(-q)                  # Only print error and warning messages
  --bare                       # Create a bare repository
  --object-format: string      # Specify the object format
  --template: path             # Repository template directory
  --separate-git-dir: path     # Set the repository .git dir to this path
  --initial-branch(-b): string # The name of the initial branch
  --shared: string             # Share the git directory
  --help                       # Show help
]

