use ../wrapper.nu [
  local_branches
]

# TODO: expand to individual commands

# Join two or more branches together
export extern "git merge" [
  commit?: string
  --commit                           # Merge and commit
  --no-commit                        # Merge but do not commit
  --edit(-e)                         # Launch EDITOR for merge message
  --no-edit                          # Accept auto-generated merge message
  --cleanup: string                  # Set merge message cleanup
  --ff                               # Attempt fast-forward
  --no-ff                            # Always create a merge commit
  --ff-only                          # Fast-forward or fail to merge
  --gpg-sign(-S): string             # GPG-sign the merge commit
  --no-gpg-sign                      # Do not GPG-sign the merge commit
  --log: number                      # Populate merge message with N commit descriptions
  --no-log                           # Do not list commit descriptions
  --signoff                          # Add signed-off-by
  --no-signoff                       # Omit signed-off-by
  --stat                             # Show diffstat
  --no-stat(-n)                      # Omit diffstat
  --squash                           # Squash merge
  --no-squash                        # Do not squash merge
  --verify                           # Run pre-merge and commit-msg hooks
  --no-verify                        # Skip pre-merge and commit-msg hooks
  --strategy(-s): string             # Choose the merge strategy
  --strategy-option(-X): string      # Set a merge strategy option
  --verify-signatures                # Verify commit signatures
  --no-verify-signatures             # Skip signature verification
  --quiet(-q)                        # Operate quietly
  --verbose(-v)                      # Be verbose
  --progress                         # Turn on progress
  --no-progress                      # Disable progress
  --autostash                        # Stash and unstash around merge
  --no-autostash                     # Disable autostash
  --allow-unrelated-histories        # Merge commits without a common ancestor
  -m: string                         # Merge message
  --into-name: string@local_branches # Prepare merge message as if merging into this branch
  --file(-F): path                   # Read commit message from this file
  --rerere-autoupdate                # Allow rerere to update the index
  --no-rerere-autoupdate             # Disallow rerere updates
  --overwrite-ignore                 # Silently overwrite ignored files
  --no-overwrite-ignore              # Abort without overwriting ignored files
  --abort                            # Abort conflict resolution
  --quit                             # Forget about the merge in progress
  --continue                         # Proceed after resolving conflicts
  --help                             # Show help
]

