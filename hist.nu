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
    config_get "completion-nu.max-commits" int
  } catch {
    100
  }

  git_commits --max-count $max_count
  | move author --after subject
  | move date --after author
}

