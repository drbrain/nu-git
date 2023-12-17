use options.nu [
  cleanup
  strategy
]

use wrapper.nu [
  branches_and_remotes
  remote_branches
]

def rebase_arg [] {
  [
    { value: "false", description: "Do not rebase" },
    { value: "interactive", description: "Interactive rebase" },
    { value: "merges", description: "Include local merge commits in the rebase" },
    { value: "true", description: "Rebase atop the upstream branch after fetching" },
  ]
}

def recurse_submodules [] {
  [
    { value: "yes", description: "Recurse into all populated submodules" },
    { value: "on-demand", description: "Recurse into changed submodules" },
    { value: "no", description: "Do not recurse into submodules" },
  ]
}

# Fetch from and integrate with another repository or a local branch
export extern main [
  repository?: string@branches_and_remotes        # The remote source repository
  ...respec: string@remote_branches               # Which refs to fetch and update locally
  --no-recurse-submodules                         # Do not update submodules when restoring
  --quiet(-q)                                     # Operate quietly
  --recurse-submodules: string@recurse_submodules # Update submodules when restoring
  --verbose(-v)                                   # Be verbose
  --commit                                        # Merge and commit
  --no-commit                                     # Merge but do not commit
  --edit(-e)                                      # Launch EDITOR for merge message
  --no-edit                                       # Accept auto-generated merge message
  --cleanup: string@cleanup                       # Set merge message cleanup
  --ff                                            # Attempt fast-forward
  --no-ff                                         # Always create a merge commit
  --ff-only                                       # Fast-forward or fail to merge
  --gpg-sign(-S): string                          # GPG-sign the merge commit
  --no-gpg-sign                                   # Do not GPG-sign the merge commit
  --log: number                                   # Populate merge message with N commit descriptions
  --no-log                                        # Do not list commit descriptions
  --signoff                                       # Add signed-off-by
  --no-signoff                                    # Omit signed-off-by
  --stat                                          # Show diffstat
  --no-stat(-n)                                   # Omit diffstat
  --squash                                        # Squash merge
  --no-squash                                     # Do not squash merge
  --verify                                        # Run pre-merge and commit-msg hooks
  --no-verify                                     # Skip pre-merge and commit-msg hooks
  --strategy(-s): string@strategy                 # Choose the merge strategy
  --strategy-option(-X): string                   # Set a merge strategy option
  --verify-signatures                             # Verify commit signatures
  --no-verify-signatures                          # Skip signature verification
  --summary                                       # Output a condensed summary of extended header information
  --autostash                                     # Stash and unstash around merge
  --no-autostash                                  # Disable autostash
  --allow-unrelated-histories                     # Merge commits without a common ancestor
  --rebase(-r): string@rebase_arg                 # Control rebasing of the current branch
  --no-rebase                                     # Merge the upstream branch into the current branch
  --all                                           # Fetch all remotes
  --append(-a)                                    # Append ref and object names of fetched refs to the existing FETCH_HEAD
  --atomic                                        # Use an atomic transaction to update local refs
  --depth: number                                 # Limit fetching to the specified number of commits from the remote tip
  --deepen: number                                # Limit fetching to the specified number of commits from the current shallow boundary
  --shallow-since: string                         # Update the history of a shallow repository to include commits after this date
  --shallow-exclude: string                       # Update the history of a shallow repository to exclude commits reachable from this revision
  --unshallow                                     # Convert a shallow repository into a complete repository
  --negotiation-tip: string                       # Report commits reachable from the given tips
  --negotiate-only                                # Only print ancestors of negotaited tips
  --dry-run                                       # Do not make changes
  --porcelain                                     # Porcelain output
  --force(-f)                                     # Force update local branches
  --keep(-k)                                      # Keep the downloaded pack
  --prefetech                                     # Modify the configured refspec to place all refs into refs/prefetch
  --prune(-p)                                     # Remove any remote-tracking references that no longer exits on the remote before fetching
  --no-tags(-n)                                   # Do not automatically fetch tags
  --refmap: string                                # Use this refspec to map refs to remote-tracking branches
  --tags(-t)                                      # Fetch tags from the remote
  --jobs(-j): number                              # Number of parallel children to use
  --set-upstream                                  # Set an upstream tracking reference
  --upload-pack: string                           # Specify a non-default path for the command run on the remote
  --progress                                      # Report progress on stderr
  --server-option(-o): string                     # Transmit the option to the server
  --show-forced-updates                           # Show if a branch is force-updated
  --no-show-forced-updates                        # Disable showing forced updates
  --ipv4(-4)                                      # Use IPv4 only
  --ipv6(-6)                                      # Use IPv6 only
]

