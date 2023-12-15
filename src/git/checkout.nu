use ../wrapper.nu [
  modified,
]

# Restore working tree files
export extern "git checkout" [
  ...pathspec: path@modified  # Limit paths to checkout
  -b: string                  # Create and checkout a new branch
  -B: string                  # Create/reset and checkout a branch
  -l                          # Create reflog for new branch
  --guess                     # Second guess 'git checkout <no-such-branch>' (default)
  --overlay                   # Use overlay mode (default)
  --quiet(-q)                 # Suppress progress reporting
  --recurse-submodules: path  # Control recursive updating of submodules
  --progress                  # Force progress reporting
  --merge(-m)                 # Perform a 3-way merge with the new branch
  --conflict: string          # Conflict style (merge or diff3)
  --detach(-d)                # Detach HEAD at named commit
  --track(-t)                 # Set upstream info for new branch
  --force(-f)                 # Force checkout (throw away local modifications)
  --orphan: string            # New unparented branch
  --overwrite-ignore          # Update ignored files (default)
  --ignore-other-worktrees    # Do not check if another worktree is holding the given ref
  --ours(-2)                  # Checkout our version for unmerged files
  --theirs(-3)                # Checkout their version for unmerged files
  --patch(-p)                 # Interactively add hunks of patch between the index and the work tree
  --ignore-skip-worktree-bits # Do not limit pathspecs to sparse entries only
  --pathspec-from-file: path  # Read pathspec from file
  --help                      # Show help
]

