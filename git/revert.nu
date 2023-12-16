use ../options.nu [
  cleanup
  strategy
]

use ../wrapper.nu [
  commits
]

# Revert some existing commits
export extern "git revert" [
  ...commits: string@commits    # Commits to revert
  --edit(-e)                    # Edit the revert commit message
  --mainline(-m): number        # Merge commit mainline commit number
  --no-edit                     # Do not edit the revert commit message
  --cleanup: string@cleanup     # How to clean the commit message
  --no-commit(-n)               # Revert, but do not commit
  --gpg-sign(-S): string        # GPG-sign commits
  --no-gpg-sign                 # Do not GPG-sign commits
  --signoff(-s)                 # Added Signed-off-by trailer to commit message
  --strategy: string@strategy   # Use this merge strategy
  --strategy-option(-X): string # Set a merge strategy-specific option
  --rerere-autoupdate           # Allow rerere to update the index
  --no-rerere-autoupdate        # Do not allow rerere to update the index
]

# Cancel the operation and return to pre-revert state
export def "git revert abort" [] {
  ^git revert --abort
}

# Continue the revert after resolving conflicts
export def "git revert continue" [] {
  ^git revert --continue
}

# Forget about the revert
export def "git revert quit" [] {
  ^git revert --quit
}

# Skip the current commit and continue with the revert
export def "git revert skip" [] {
  ^git revert --skip
}

