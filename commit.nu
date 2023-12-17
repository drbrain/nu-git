use ../wrapper.nu [
  commits,
  modified,
]

use ../options.nu [
  cleanup,
]

def untracked [] {
  [
    { value: "no", description: "Show no untracked files" },
    { value: "normal", description: "Show untracked files and directories" },
    { value: "all", description: "Show files in untracked directories" },
  ]
}

# Record changes to the repository
export extern "git commit" [
  ...pathspec: path@modified              # Paths to commit
  --all(-a)                               # Include modified and deleted files
  --interactive                           # Interactively add hunks of patch between the index and the work tree
  --patch(-p)                             # Interactively add hunks of patch between the index and the work tree
  --signoff(-s)                           # Add signed-off-by
  --verbose(-v)                           # Include diff in the commit message template
  --untracked-files(-u): string@untracked # Show untracked files
  --amend                                 # Replace the latest commit with an amended commit
  --dry-run                               # Do not create a commit, show a list of paths to be committed
  --squash: string@commits                # Construct a commit message for use with rebase --autosquash
  --reedit-message(-c): string@commits    # Like -C, but also open the editor
  --reuse-message(-C): string@commits     # Reuse the message and authorship from a previous commit
  --fixup: string                         # Create a new commit which fixes up another commit
  --file(-F): path                        # Take the commit message from a file
  --message(-m): string                   # Use this commit message
  --reset-author                          # Reset author when using -C/-c/--amend
  --allow-empty                           # Allow an empty commit
  --allow-empty-message                   # Allow an empty message
  --verify                                # Run pre-commit and commit-msg hooks
  --no-verify(-n)                         # Bypass pre-command and commit-msg hooks
  --author: string                        # Override the commit author
  --date: string                          # Override the author date
  --cleanup: string@cleanup               # How to clean up the commit message
  --no-status                             # Omit git-status output from the commit message template
  --status                                # Inculde git-status output in the commit message template
  --include(-i)                           # Also stage contents of given paths
  --only(-o)                              # Ignore staged contents, use only command line paths
  --pathspec-from-file: path              # Read <pathspec> from this file
  --pathspec-file-nul                     # NUL separator for --path-spec-from-file
  --trailer: string                       # Add a commit trailer
  --gpg-sign(-S): string                  # GPG-sign commits
  --no-gpg-sign                           # Do not GPG-sign commits
]

