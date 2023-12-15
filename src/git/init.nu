def format [] {
  [
    { value: "sha1", description: "SHA-1" },
    { value: "sha256", description: "SHA-256 (if enabled)" },
  ]
}

def shared [] {
  [
    { value: "false", description: "Use umask permissions" },
    { value: "true", description: "Group-writable" },
    { value: "umask", description: "Use umask permissions" },
    { value: "group", description: "Group-writable" },
    { value: "all", description: "World-writable" },
    { value: "world", description: "World-writable" },
    { value: "everybody", description: "World-writable" },
  ]
}

# Create or reinitialize a git repository
export extern "git init" [
  directory: path                # Directory to create a git repository in
  --quiet(-q)                    # Only print error and warning messages
  --bare                         # Create a bare repository
  --object-format: string@format # Specify the object format
  --template: path               # Repository template directory
  --separate-git-dir: path       # Set the repository .git dir to this path
  --initial-branch(-b): string   # The name of the initial branch
  --shared: string@shared        # Share the git directory
]

