use options.nu [
  cleanup
  strategy
]

use wrapper.nu [
  current_branch
  local_branches
]

def mergeable [] {
  let current = current_branch
  local_branches
  | where {||
    $in.value != $current
  }
}

# Join two or more branches together
export extern main [
  ...commits: string@mergeable       # Commits to merge into the current branch
  --commit                           # Merge and commit (overrides --no-commit)
  --no-commit                        # Merge but do not commit
  --edit(-e)                         # Launch EDITOR for merge message
  --no-edit                          # Accept auto-generated merge message
  --cleanup: string@cleanup          # Set merge message cleanup
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
  --strategy(-s): string@strategy    # Choose the merge strategy
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
]

# Abort the merge and try to reconstruct the pre-merge state
export def abort [] {
  ^git merge --abort
}

# Proceed with the merge after resolving conflicts
export def continue [] {
  ^git merge --continue
}

# Forget about the murge in-progress
#
# Leave the index and working tree as-is
export def quit [] {
  ^git merge --quit
}
