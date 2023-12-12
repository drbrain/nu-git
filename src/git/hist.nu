# Show a simplified view of recent history
export def "git hist" [
  --max-count: int = 500 # Number of commits to show
] {
  git_commits --max-count $max_count
  | move author --after subject
  | move date --after author
  | explore
}

