use wrapper.nu [
  submodule_status
]

alias nu-update = update

# Initialize, update, or inspect submodules
export extern main [
  --cached # Use the index commit instead of the HEAD commit
  --quiet  # Only print error messages
]

# Absorb git directories into submodules
export extern absorbgitdirs [
  ...path: path # Path to absorb
  --quiet       # Only print error messages
]

# Add a submodule
export extern add [
  repository: string  # Repository to add as a submodule
  path?: path         # Location of the cloned submodule
  -b: string          # Branch of submodule repository
  --force(-f)         # Allow adding an ignored submodule path
  --name: string      # Name of submodule
  --reference: string # Obtain objects from a local reference repository
  --depth: number     # Truncate history depth
  --quiet             # Only print error messages
]

# Unregister submodules
#
# Use git rm to remove a submodule
export extern deinit [
  ...path: path # Paths to remove
  --force(-f)   # Remove submodule working trees with local changes
  --all         # Unregister all submodules
  --quiet       # Only print error messages
]

# Initialize submodules recorded in the index
export extern init [
  ...path: path # Submodules to initialize
  --quiet       # Only print error messages
]

# Run arbitrary shell commands in each submodule
export extern foreach [
  command: string # Command to run
  --recursive     # Execute on submodules recursively
  --quiet         # Don't print submodule names before execution
]

# Set the default remote tracking branch
export extern "set-branch" [
  branch: string       # Branch to set
  path: path           # Submodule path
  --branch(-b): string # Branch to use
  --default(-d)        # Set the tracking branch to the default remote HEAD
  --quiet              # Only print error messages
]

# Set a submodule URL
export extern "set-url" [
  path: path     # Submodule path
  newurl: string # URL of set
  --quiet        # Only print error messages
]

# Show the status of submodules
export def status [
  --recursive
] {
  submodule_status $recursive
  | nu-update SHA { |r| $r.SHA | str substring 0..8 }
  | sort
}

# Show the commit summary between the commit and the working tree or index
export extern summary [
  commit?: string            # Start commit
  ...path: path              # Submodule path
  --cached                   # Use the index commit
  --files                    # Show commits between the superproject index and the submodule working tree
  --summary-list(-n): number # Limit summary size to this many commits
  --quiet                    # Only print error messages
]

# Synchronize submodule remote settings with .gitmodules
export extern sync [
  ...path: path # Submodule path
  --recursive   # Recurse into registered submodules
  --quiet       # Only print error messages
]

# Update the registered submodules to match the superproject expectations
export extern update [
  ...path: path          # Submodules path
  --init                 # Initialize all unititialized submodules
  --remote               # Update using the submodule's remote tracking branch
  --no-fetch(-N)         # Don't fetch new objects from the remote
  --recommend-shallow    # Use recommended shallow setting
  --no-recommend-shallow # Ignore shallow recommendations
  --force(-f)            # Discard local changes switching commits
  --checkout             # Checkout the commit in the superproject on a detatched HEAD
  --rebase               # Rebase the current branch onto the commit recorded in the superproject
  --merge                # Merge the superproject commit into the current branch
  --reference: string    # Obtain objects from a local reference repository
  --depth: number        # Truncate history depth
  --recursive            # Recurse into registered submodules
  --jobs: number         # How many submodules to clone at once
  --single-branch        # Clone history leading to the tip of a single branch
  --no-single-branch     # Override --single-branch
  --filter: string       # Use the partial clone feature with this filter
  --quiet                # Only print error messages
]

