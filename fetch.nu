# Download objects and refs from another repository
export extern main [
  repository: string                   # The remote repository or group of repositories
  ...refspec: string                   # Refs to fetch and local refs to update
  --all                                # Fetch all remotes
  --append(-a)                         # Append ref and object names of fetched refs to the existing FETCH_HEAD
  --atomic                             # Use an atomic transaction to update local refs
  --depth: number                      # Limit fetching to the specified number of commits from the remote tip
  --deepen: number                     # Limit fetching to the specified number of commits from the current shallow boundary
  --shallow-since: string              # Update the history of a shallow repository to include commits after this date
  --shallow-exclude: string            # Update the history of a shallow repository to exclude commits reachable from this revision
  --unshallow                          # Convert a shallow repository into a complete repository
  --update-shallow                     # Accept refs that require updating .git/shallow
  --negotiation-tip: string            # Report commits reachable from the given tips
  --negotiate-only                     # Only print ancestors of negotaited tips
  --dry-run                            # Do not make changes
  --porcelain                          # Porcelain output
  --write-fetch-head                   # Write the list of remote refs fetched in FETCH_HEAD
  --no-write-fetch-head                # Do not write the remote refs fetched
  --force(-f)                          # Force update local branches
  --keep(-k)                           # Keep the downloaded pack
  --multiple                           # Allow serveral repository and group arguments
  --auto-maintenance                   # Run automatic repository maintenance if needed
  --no-auto-maintenance                # Do not run automatic maintenance
  --auto-gc                            # Run automatic repository maintenance if needed
  --no-auto-gc                         # Do not run automatic maintenance
  --write-commit-graph                 # Write a commit graph after fetching
  --no-write-commit-graph              # Do not write a commit graph after fetching
  --prefetech                          # Modify the configured refspec to place all refs into refs/prefetch
  --prune(-p)                          # Remove any remote-tracking references that no longer exits on the remote before fetching
  --prune-tags(-P)                     # Remove any local tags that no longer exist on the remote before fetching
  --no-tags(-n)                        # Do not automatically fetch tags
  --refetch                            # Fetch all objects like a fresh clone would
  --refmap: string                     # Use this refspec to map refs to remote-tracking branches
  --tags(-t)                           # Fetch tags from the remote
  --recurse-submodules: string         # Set submodule recursion fetching
  --jobs(-j): number                   # Number of parallel children to use
  --no-recurse-submodules              # Disable recursive fetching of submodules
  --set-upstream                       # Set an upstream tracking reference
  --submodule-prefix: path             # Prepend this path to printed submodule paths
  --recurse-submodules-default: string # Set a temporary non-negative default value for--recurse-submodules
  --update-head-ok(-u)                 # Update the head that corresponds to the current branch
  --upload-pack: string                # Specify a non-default path for the command run on the remote
  --quiet(-q)                          # Do not report progress
  --verbose(-v)                        # Be verbose
  --progress                           # Report progress on stderr
  --server-option(-o): string          # Transmit the option to the server
  --show-forced-updates                # Show if a branch is force-updated
  --no-show-forced-updates             # Disable showing forced updates
  --ipv4(-4)                           # Use IPv4 only
  --ipv6(-6)                           # Use IPv6 only
]

