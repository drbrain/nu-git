use ../options.nu [
  color,
  column,
]

use ../wrapper.nu [
  branches_and_remotes,
]

def track [] {
  [
    { value: "direct", description: "Use the start point branch as the upstream" },
    { value: "inherit", description: "Copy the start point upstream configuration" },
  ]
}

# Create, list, delete, rename, etc. branches
export def "git branch" [] {
  help git branch
}

# Copy a branch
export def "git branch copy" [
  --force                             # Force branch creation
  --from: string@branches_and_remotes # Branch to copy from
  new_branch: string                  # New branch name
] {
  mut args = []

  if $force {
    $args = ( $args | append "-C" )
  } else {
    $args = ( $args | append "-c" )
  }

  if $from != null {
    $args = ( $args | append $from )
  }

  let args = ( $args | append $new_branch )

  run-external "git" "branch" $args
}

# Create a branch
export def "git branch create" [
  --force                   # Force branch creation
  --no-track                # Do not track an upstream branch
  --recurse-submodules      # Also create the branch on submodules
  --track(-t): string@track # Track an upstream branch
  branch_name: string       # Branch name
  start_point: string       # Branch start point
] {
  mut args = []

  if $force {
    $args = ( $args | append "--force" )
  }

  if $recurse_submodules {
    $args = ( $args | append "--recurse-submodules" )
  }

  if $track != null {
    $args = ( $args | append [ "--track" $track ] )
  }

  if $no_track {
    $args = ( $args | append "--no-track" )
  }

  $args = ( $args | append $branch_name )

  if $start_point != null {
    $args = ( $args | append $start_point )
  }

  let args = $args

  run-external "git" "branch" $args
}

# The current branch name
export def "git branch current" [] {
  run-external --redirect-stdout "git" "branch" "--show-current"
  | into string
  | str trim
}

# Delete branches
export def "git branch delete" [
  --force                                  # Force branch deletion
  --remotes(-r)                            # Delete remote tracking branches
  ...branches: string@branches_and_remotes # Branch patters
] {
  mut args = []

  if $force {
    $args = ( $args | append "-D" )
  } else {
    $args = ( $args | append "-d" )
  }

  if $remotes {
    $args = ( $args | append "--remotes" )
  }

  let args = ( $args | append $branches )

  run-external "git" "branch" $args
}

# List branches
export def "git branch list" [
  --abbrev: int                            # Abbreviate object names
  --all(-a)                                # List local and remote-tracking branches
  --color: string@color                    # Color branches to highlight types of branch
  --column: string@column                  # Display branches in columns
  --contains: string                       # List branches with this commit
  --format: string                         # Format of branch list output
  --merged: string                         # Only list branches reachable from this commit
  --no-abbrev                              # Do not abbreviate object names
  --no-color                               # Do not color branches
  --no-column                              # Do not output in columns
  --no-contains: string                    # Only list branches without this commit
  --no-merged: string                      # Only list branches that are not reachable from this commit
  --points-at: string                      # Only list branches of this object
  --remotes(-r)                            # List the remote tracking branch
  --sort: string                           # Sort based on the given key
  ...branches: string@branches_and_remotes # Branch patterns to list
] {
  mut args = [ "--list" ]

  if $abbrev != null {
    $args = ( $args | append [ "--abbrev" $abbrev ] )
  }

  if $all {
    $args = ( $args | append [ "--all" ] )
  }

  if $color != null {
    $args = ( $args | append [ "--color" $color ] )
  }

  if $column != null {
    $args = ( $args | append [ "--column" $column ] )
  }

  if $contains != null {
    $args = ( $args | append [ "--contains" $contains ] )
  }

  if $format != null {
    $args = ( $args | append [ "--format" $format ] )
  } else {
    $args = (
      $args
      | append [
        "--format"
        "%(refname:lstrip=2)%00%(HEAD)%00%(upstream:lstrip=2)%00%(objectname:short)"
      ]
    )
  }

  if $merged != null {
    $args = ( $args | append [ "--merged" $merged ] )
  }

  if $no_abbrev {
    $args = ( $args | append [ "--no-abbrev" ] )
  }

  if $no_color {
    $args = ( $args | append [ "--no-color" ] )
  }

  if $no_column {
    $args = ( $args | append [ "--no-column" ] )
  }

  if $no_contains != null {
    $args = ( $args | append [ "--no-contains" $no_contains ] )
  }

  if $no_merged != null {
    $args = ( $args | append [ "--no-merged" $no_merged ] )
  }

  if $remotes {
    $args = ( $args | append [ "--remotes" ] )
  }

  if $sort != null {
    $args = ( $args | append [ "--sort" $sort ] )
  }

  let args = ( $args | append $branches )

  run-external --redirect-stdout "git" "branch" $args
  | lines
  | each {||
    $in
    | split column "\u{0}"
  }
  | flatten
  | rename branch current upstream object
  | upsert current {|| $in.current == "*" }
}

# Edit the description for a branch
export def "git branch edit-description" [
  branch: string@branches_and_remotes # Branch name
] {
  run-external "git" "branch" "--edit-description" $branch
}

# Rename a branch
export def "git branch rename" [
  --force                             # Force branch rename
  --from: string@branches_and_remotes # Branch to rename
  new_branch: string                  # New branch name
] {
  mut args = []

  if $force {
    $args = ( $args | append "-M" )
  } else {
    $args = ( $args | append "-m" )
  }

  if $from != null {
    $args = ( $args | append $from )
  }

  let args = ( $args | append $new_branch )

  run-external "git" "branch" $args
}

# Remove the upstream for a branch
export def "git branch upstream remove" [
  branch: string@branches_and_remotes # Branch name
] {
  ^git branch --unset-upstream $branch
}

# Set the upstream branch for a branch
export def "git branch upstream set" [
  upstream: string                    # Upstream to track
  branch: string@branches_and_remotes # Branch name
] {
  ^git branch --set-upstream-to $upstream $branch
}
