use options.nu [
  conflict
  track
]

use wrapper.nu [
  branches_and_remotes
]

def args [
  conflict
  discard_changes
  force
  force_create
  guess
  ignore_other_worktrees
  merge
  no_progress
  recurse_submodules
  track
  --no-track
  --progress
  --quiet
] {
  mut args = []
  if $conflict != null { $args = ( $args | append [ "--conflict" $conflict ]) }
  if $discard_changes { $args = ( $args | append "--discard-changes" ) }
  if $force { $args = ( $args | append "--force" ) }
  if $force_create != null { $args = ( $args | append [ "--force-create" $force_create ]) }
  if $guess { $args = ( $args | append "--guess" ) }
  if $ignore_other_worktrees { $args = ( $args | append "--ignore-other-worktrees" ) }
  if $merge { $args = ( $args | append "--merge" ) }
  if $no_progress { $args = ( $args | append "--no-progress" ) }
  if $no_track { $args = ( $args | append "--no-track" ) }
  if $progress { $args = ( $args | append "--progress" ) }
  if $quiet { $args = ( $args | append "--quiet" ) }
  if $recurse_submodules { $args = ( $args | append "--recurse-submodules" ) }
  if $track != null { $args = ( $args | append [ "--track" $force_create ]) }

  $args
}

# Switch to an existing branch
export def main [
  branch: string@branches_and_remotes # Branch to switch to
  --conflict: string@conflict          # Like --merge, but show conflicting hunks
  --discard-changes                    # Proceed even if the index or working tree differs from HEAD
  --force(-f)                          # Proceed even if the index or working tree differs from HEAD
  --force-create(-C): string           # Create a new branch, but reset its start point
  --guess                              # Try to track a remote branch (default behavior)
  --ignore-other-worktrees             # Check out the ref even if checked out by another work tree
  --merge(-m)                          # Merge local changes when switching branches
  --no-guess                           # Do not try to guess a tracking branch
  --no-progress                        # Do not show progress
  --no-track                           # Do not set up upstream configuration
  --progress                           # Report progress on stderr, even without a terminal
  --quiet(-q)                          # Quiet
  --recurse-submodules                 # Update active submodules
  --track(-t): string@track            # Set up upstream configuration when creating a branch
] {
  mut args = args $conflict $discard_changes $force $force_create $guess $ignore_other_worktrees $merge $no_progress $recurse_submodules $track --no-track=$no_track --progress=$progress --quiet=$quiet
  if $no_guess { $args = ( $args | append "--no-guess" ) }

  let args = $args | append $branch

  run-external "git" "switch" ...$args
}

# Create a new branch
export def create [
  new_branch: string
  start_point?: string
  --conflict: string@conflict          # Like --merge, but show conflicting hunks
  --discard-changes                    # Proceed even if the index or working tree differs from HEAD
  --force(-f)                          # Proceed even if the index or working tree differs from HEAD
  --force-create(-C): string           # Create a new branch, but reset its start point
  --guess                              # Try to track a remote branch (default behavior)
  --ignore-other-worktrees             # Check out the ref even if checked out by another work tree
  --merge(-m)                          # Merge local changes when switching branches
  --no-progress                        # Do not show progress
  --no-track                           # Do not set up upstream configuration
  --progress                           # Report progress on stderr, even without a terminal
  --quiet(-q)                          # Quiet
  --recurse-submodules                 # Update active submodules
  --track(-t): string@track            # Set up upstream configuration when creating a branch
] {
  mut args = args $conflict $discard_changes $force $force_create $guess $ignore_other_worktrees $merge $no_progress $recurse_submodules $track --no-track=$no_track --progress=$progress --quiet=$quiet

  if $force_create == null { $args = ( $args | append "--create" ) }

  let args = $args | append [ $new_branch $start_point ] | compact

  run-external "git" "switch" ...$args
}

# Switch to the default branch
export def default [] {
  # TODO: Determine correct remote, "origin" may not exist
  let head = "refs/remotes/origin/HEAD"

  # TODO: Handle "/" in default branch name
  let default = run-external "git" "symbolic-ref" $head
  | path basename

  let current = run-external "git" "branch" "--show-current"

  if $default == $current {
    return 
  }

  run-external "git" "switch" $default
}

# Switch to a commit for inspection and experiments
export def detach [
  start_point: string # Commit to detach
  --conflict: string@conflict          # Like --merge, but show conflicting hunks
  --discard-changes                    # Proceed even if the index or working tree differs from HEAD
  --force(-f)                          # Proceed even if the index or working tree differs from HEAD
  --force-create(-C): string           # Create a new branch, but reset its start point
  --guess                              # Try to track a remote branch (default behavior)
  --ignore-other-worktrees             # Check out the ref even if checked out by another work tree
  --merge(-m)                          # Merge local changes when switching branches
  --no-progress                        # Do not show progress
  --no-track                           # Do not set up upstream configuration
  --progress                           # Report progress on stderr, even without a terminal
  --quiet(-q)                          # Quiet
  --recurse-submodules                 # Update active submodules
  --track(-t): string@track            # Set up upstream configuration when creating a branch
] {
  mut args = args $conflict $discard_changes $force $force_create $guess $ignore_other_worktrees $merge $no_progress $recurse_submodules $track --no-track=$no_track --progress=$progress --quiet=$quiet

  let args = $args | append $start_point

  run-external "git" "switch" "--detach" ...$args
}

# Create a new orphan branch
export def orphan [
  new_branch: string # Branch name
  --conflict: string@conflict          # Like --merge, but show conflicting hunks
  --discard-changes                    # Proceed even if the index or working tree differs from HEAD
  --force(-f)                          # Proceed even if the index or working tree differs from HEAD
  --force-create(-C): string           # Create a new branch, but reset its start point
  --guess                              # Try to track a remote branch (default behavior)
  --ignore-other-worktrees             # Check out the ref even if checked out by another work tree
  --merge(-m)                          # Merge local changes when switching branches
  --no-progress                        # Do not show progress
  --no-track                           # Do not set up upstream configuration
  --progress                           # Report progress on stderr, even without a terminal
  --quiet(-q)                          # Quiet
  --recurse-submodules                 # Update active submodules
  --track(-t): string@track            # Set up upstream configuration when creating a branch
] {
  mut args = args $conflict $discard_changes $force $force_create $guess $ignore_other_worktrees $merge $no_progress $recurse_submodules $track --no-track=$no_track --progress=$progress --quiet=$quiet

  let args = $args | append $new_branch

  run-external "git" "switch" ...$args
}

