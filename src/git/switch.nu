use ../wrapper.nu [
  branches_and_remotes,
]

export def conflict_style [] {
  [
    { value: "merge", description: "RCS style" },
    { value: "diff3", description: "RCS style with base hunk" },
    { value: "zdiff3", description: "diff3 omitting common lines in the conflict" },
  ]
}

# Switch branches
export extern "git switch" [
  branch?: string@branches_and_remotes # Branch to switch to
  start_point?: string                 # Starting point for the new branch
  --conflict: string@conflict_style    # Like --merge, but show conflicting hunks
  --create(-c): string                 # Create a new branch
  --detach(-d)                         # Switch to a commit for inspection or experiments
  --discard-changes                    # Proceed even if the index or working tree differs from HEAD
  --force(-f)                          # Proceed even if the index or working tree differs from HEAD
  --force-create(-C): string           # Create a new branch, but reset its start point
  --guess                              # Try to track a remote branch (default behavior)
  --ignore-other-worktrees             # Check out the ref even if checked out by another work tree
  --merge(-m)                          # Merge local changes when switching branches
  --no-guess                           # Do not try to guess a tracking branch
  --no-progress                        # Do not show progress
  --no-track                           # Do not set up upstream configuration
  --orphan: string                     # Create a new orphan branch
  --progress                           # Report progress on stderr, even without a terminal
  --quiet(-q)                          # Quiet
  --recurse-submodules                 # Update active submodules
  --track(-t): string                  # Set up upstream configuration when creating a branch
  --help                               # Show help
]

