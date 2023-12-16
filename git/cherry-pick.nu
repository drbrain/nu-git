use ../options.nu [
  strategy,
]

use ../wrapper.nu [
  commits
]

# Apply changes introduced by existing commits
export extern "git cherry-pick" [
  ...commits: string@commits      # Commit to cherry-pick
  --edit(-e)                      # Edit the message prior to committing
  --cleanup: string               # Set message cleanup mode
  -x                              # Append "(cherry picked from commit ...)" to message
  -r                              # Don't do -x (deprecated)
  --mainline(-m): number          # Set mainline when cherry-picking a merge commit
  --no-commit(-n)                 # Apply changes without creating a commit
  --signoff(-s)                   # Add signed-off-by
  --gpg-sign(-S): string          # GPG-sign commits
  --no-gpg-sign                   # Do not GPG-sign commits
  --ff                            # Attempt fast-forward
  --allow-empty                   # Allow an empty commit
  --allow-empty-message           # Allow an empty message
  --keep-redundant-commits        # Allow a redundant commit
  --strategy(-s): string@strategy # Choose the merge strategy
  --strategy-option(-X): string   # Set a merge strategy option
  --rerere-autoupdate             # Allow rerere to update the index
  --no-rerere-autoupdate          # Disallow rerere updates
  --continue                      # Proceed after resolving conflicts
  --skip                          # Skip commit and continue operation
  --quit                          # Forget the in-progress operation
  --abort                         # Cancel the operation
]

# TODO: Split --continue, etc. into separate commands
