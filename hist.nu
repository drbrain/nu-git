use wrapper.nu [
  config_get
  git_commits
]

# Show a simplified view of recent history
#
# Count defaults to 100 if `completion-nu.max-commits` config is not set
export def main [
  --max-count: int # Number of commits to show
] {
  let max_count = try {
    config_get "nu-git.max-commits" int
  } catch {
    (term size).rows - 4
  }

  let max_count = if $max_count != null {
    $max_count
  } else {
    (term size | get rows) - 10
  }

  git_commits --max-count=$max_count
  | move author --after subject
  | move date --after author
}

