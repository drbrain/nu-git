use ../wrapper.nu [
  modified,
]

# Restore working tree files
export extern "git restore" [
  ...pathspec: path@modified  # Paths to restore
  --source(-s): string        # Restore the working tree with content from this tree
  --patch(-p)                 # Interactively add hunks of patch between the index and the work tree
  --worktree(-W)              # Restore from worktree
  --staged(-S)                # Restore from index
  --quiet(-q)                 # Supress feedback
  --progress                  # Show progress status
  --no-progress               # Don't show progress status
  --ours                      # Restore file from our index
  --theirs                    # Restore file from their index
  --merge(-m)                 # Recreate the conflicted merge in unmrged paths
  --conflict: string          # Present conflicts with this style
  --ignore-unmerged           # Do not abort if there are unmerged entries
  --ignore-skip-worktree-bits # Do not limit pathspecs to sparse entries only
  --recurse-submodules        # Update submodules when restoring
  --no-recurse-submodules     # Do not update submodules when restoring
  --overlay                   # Do not remove files when restoring
  --no-overlay                # Remove index-deleted tracked files when restoring
  --pathspec-file-nul         # NUL separator for --pathspec-from-file
  --pathspec-from-file: path  # Read <pathspec> from this file
  --help                      # Show help
]

