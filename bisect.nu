alias nu-help = help

# Use binary search to find the commit that introduced a bug
export def main [] {
  nu-help bisect
}

# Start bisecting commits
export extern start [
  --term-new: string  # Custom term for "new" commits
  --term-bad: string  # Custom term for "bad" commits
  --term-old: string  # Custom term for "old" commits
  --term-good: string # Custom term for "good" commits
  --no-checkout       # Do not checkout the new working tree at each step
  --first-parent      # Follow only the first parent commit upon seeing a merge commit
  ...commits: string  # <bad> <good> -- <...path>
]

# Mark a commit as bad
export extern bad [
  rev: string # Revision to mark bad
]

# Mark a commit as new
export extern new [
  rev: string # Revision to mark new
]

# Mark commits as good
export extern good [
  ...rev: string # Revisions to mark good
]

# Mark commits as old
export extern old [
  ...rev: string # Revisions to mark old
]

# Show custom terms in use
export def terms [] {
  run-external --redirect-stdout git bisect terms
  | parse -r "Your current terms are (?<old>.*) for the old state\nand (?<new>.*) for the new state."
  
}

# Skip testing a commit
export extern skip [
  ...rev: string # Revisions to skip
]

# Clean up bisection and return to the original HEAD
export extern reset [
  commit?: string # Commit to return to
]

# Visualize remaining suspects in gitk
export extern visualize []

# View remaining suspects in gitk
export extern view []

# Replay a bisect log
export extern replay [
  logfile: path # Log to replay
]

# Show what has been done so far
export extern log []

# Command to run to test a revision
export extern run [
  command: string # Command that runs a test
  ...args: string # Command arguments
]

# Bisect interactively
export extern help []
