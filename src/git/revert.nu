# TODO: expand to individual commands

# Revert some existing commits
export extern "git revert" [
  commit?: string
  --edit(-e)                    # Edit the revert commit message
  --mainline(-m): number        # Merge commit mainline commit number
  --no-edit                     # Do not edit the revert commit message
  --cleanup: string             # How to clean the commit message
  --no-commit(-n)               # Revert, but do not commit
  --gpg-sign(-S): string        # GPG-sign commits
  --no-gpg-sign                 # Do not GPG-sign commits
  --signoff(-s)                 # Added Signed-off-by trailer to commit message
  --strategy: string            # Use this merge strategy
  --strategy-option(-X): string # Set a merge strategy-specific option
  --rerere-autoupdate           # Allow rerere to update the index
  --no-rerere-autoupdate        # Do not allow rerere to update the index
  --continue                    # Continue the revert operation
  --skip                        # Skip commit and continue operation
  --quit                        # Forget the in-progress operation
  --abort                       # Cancel the operation
  --help                        # Show help
]

