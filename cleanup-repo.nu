# Adapted from original by Yorick Sijsling
# Adapted from bash version by Rob Miller <rob@bigfish.co.uk>

use wrapper.nu [
  config_get
  current_branch
  git_remotes
]

# Delete local (and optionally remote) merged branches
#
# Set cleanup-repo.keep locally to a space-separated list of branch patterns to keep
export def main [
  upstream: string@remotes = "origin" # Upstream remote repository
] {
  let current_branch = current_branch
  let default_branch = get_default_branch $"refs/remotes/($upstream)/HEAD"
  let keep = get_keep

  # Switch to the default branch
  switch_branch $default_branch

  # Make sure we're working with the most up-to-date version of the default
  # branch.
  run-external "git" "fetch"

  # Prune obsolete remote tracking branches. These are branches that we
  # once tracked, but have since been deleted on the remote.
  run-external "git" "remote" "prune" $upstream

  # Delete local branches that have been fully merged into the default branch
  list_merged $upstream $default_branch $keep
  | each {|branch|
    delete_local $branch
  }

  # Again with remote branches
  let merged_on_remote = list_merged --remote $upstream $default_branch $keep

  if not ( $merged_on_remote | is-empty ) {
    print "The following remote branches are fully merged and will be removed:"

    $merged_on_remote
    | each {||
      print $"\t($in)"
    }

    print ""

    if ( input --suppress-output "Continue (y/N)? " | str trim ) == "y" {
      $merged_on_remote
      | each {|branch|
        delete_remote $upstream $branch
      }
    }
  }

  switch_branch $current_branch
}

# Delete a local branch
def delete_local [
  branch: string # Branch to delete
] {
 run-external "git" "branch" "--delete" $branch
}

# Delete a remote branch
def delete_remote [
  upstream: string # Repository to delete from
  branch: string   # branch to delete
] {
  run-external "git" "push" "--quiet" "--delete" $upstream $branch
}

# Get the default branch
def get_default_branch [
  upstream: string # Repository to get the upstream branch name from
] {
  let args = [
    "--short"
    $upstream
  ]

  run-external "git" "symbolic-ref" ...$args
  | str trim
  | path basename
}

# Get the local set of branches to always keep
def get_keep [] {
  try {
    config_get "cleanup-repo.keep"
    | split row " "
  } catch {
    []
  }
}

# List all the branches that have been merged fully into the default branch.
#
# We use the remote default branch here, just in case our local default branch is out of date.
def list_merged [
  --remote           # List remote branches (local default)
  upstream: string   # Upstream repository
  branch: string     # Default branch
  keep: list<string> # Patterns to keep. The default branch and HEAD will be added
] {
  mut args = [
    "--list"
    "--merged" $"($upstream)/($branch)"
  ]

  if $remote {
    $args = ( $args | append [
      "--format" "%(refname:lstrip=3)"
      "--remote"
    ])
  } else {
    $args = ( $args | append [
      "--format" "%(refname:lstrip=2)"
    ])
  }

  let args = $args

  let keep = (
    $keep
    | append [
      "HEAD",
      $branch,
    ]
  )

  run-external "git" "branch" ...$args
  | lines
  | filter {|branch|
    $keep
    | all {|pattern|
      $branch !~ $pattern
    }
  }
}

def remotes [] {
  git_remotes
  | select name url
  | rename value description
  | uniq
  | sort
}

# Switch to a different branch
def switch_branch [
  branch: string
] {
  let args = [
    "--quiet"
    "--no-guess"
    $branch
  ]

  run-external "git" "switch" ...$args
}
