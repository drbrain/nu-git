# Clone a repository into a new directory
export extern "git clone" [
  --local(-l)                 # Copy HEAD, objects, and refs directories from a local repo
  --no-hardlinks              # Don't use hard links to .git/objects when cloning a local repo
  --shared(-s)                # Share objects with a local repo (instead of hard links)
  --reference: string         # Obtain objects from a local reference repository
  --reference-if-able: string # Obtain objects from a local reference repository if it exists
  --dissociate                # Borrow objects from reference repos only to reduce network transfer
  --quiet(-q)                 # Operate quietly
  --verbose(-v)               # Run verbosely
  --progress                  # Force progress even when stderr is not a TTY
  --server-option: string     # Send an option string to the server
  --no-checkout(-n)           # Do not check out HEAD after cloning
  --reject-shallow            # Fail if the source repo is shallow
  --no-reject-shallow         # Allow a shallow source repo
  --bare                      # Make a bare git repository
  --sparse                    # Make a sparse checkout
  --filter: string            # Use the partial clone feature with this filter
  --also-filter-submodules    # Apply the clone filter to submodules
  --mirror                    # Mirror the source repository
  --origin(-o): string        # Set the name of the upstream repository
  --branch(-b): string        # Set HEAD to this branch
  --upload-pack(-u): string   # Run a different upload-pack for SSH repos
  --template: path            # Specify the template directory
  --config(-c): string        # Set a configuration variable in the cloned repo
  --depth: number             # Truncate history depth
  --shallow-since: string     # Truncate history depth to a date
  --shallow-exclude: string   # Truncate history reachable from a revision
  --single-branch             # Clone history leading to the tip of a single branch
  --no-single-branch          # Override --single-branch
  --no-tags                   # Don't clone tags
  --recurse-submodules: path  # Initialize and clone submodules
  --shallow-submodules        # Clone submodules with a depth of 1
  --no-shallow-submodules     # Override --shallow-submodules
  --remote-submodules         # Use the submodule remote tracking branch to update the submodule
  --no-remote-submodules      # Use the super-project's commit when cloning submodules
  --jobs(-j): number          # How many submodules to clone at once
  repository: string          # Repository to clone
  directory?: path            # Directory to clone into
]

