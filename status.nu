use wrapper.nu [
  git_status
]

# TODO: support more args
#export extern "git status" [
#  ...pathspec: path             # Paths to get status for
#  --short(-s)                   # Use short format
#  --branch(-b)                  # Show branch and tracking info
#  --porcelain: number           # Use specified porcelain format
#  --porcelain                   # Use porcelain format
#  --long                        # Use long format
#  --verbose(-v)                 # Show staged changes to be committed
#  --untracked-files(-u)         # Show untracked files
#  --untracked-files(-u): string # Show untracked files
#  --ignore-submodules           # Ignore changes to submodules
#  --ignore-submodules: string   # Ignore changes to submodules
#  --ignored                     # Show ignored files
#  --ignored: string             # Show ignored files
#  -z                            # Terminate entries with NUL
#  --column                      # Display untracked files in columns
#  --column: string              # Display untracked files in columns
#  --no-column                   # Do not display untracked files in columns
#  --ahead-behind                # Display ahead/behind counts relative to upstream
#  --no-ahead-behind             # Do not display ahead/behind counts relative to upstream
#  --renames                     # Detect renames
#  --no-renames                  # Do not detect renames
#  --find-renames                # Find renames
#  --find-renames: number        # Find renames up to a similarity threshold
#  --help                        # Show help
#]

# Show the working tree status
export def main [--ignored] {
  git_status --ignored=$ignored
  | select name status staged unstaged --optional
}

