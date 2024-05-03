use wrapper.nu [
  git_dir
]

alias nu-help = help

def unknown_term [span] {
  error make {
    msg: "Unknown bisect term or command"
    label: {
      text: "unknown term"
      span: $span
    }
  }
}

# Use binary search to find the commit that introduced a bug
export def main [
  term?: string@terms # Mark commit as term
  ...rev: string      # Revisions to mark
] {
  let repo = git_dir
  let start = ( $repo | path join "BISECT_START" )
  let bisect_terms = ( $repo | path join "BISECT_TERMS" )

  if not ( $start | path exists ) {
    error make -u {
      msg: "Not currently bisecting, try git bisect start"
    }
  } else if ( $term != null and ( $bisect_terms | path exists )) {
    let terms = open $bisect_terms
    | lines

    if $term in $terms {
      run-external "git" "bisect" $term $rev
    } else {
      unknown_term (metadata $term).span
    }
  } else {
    unknown_term (metadata $term).span
  }
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
  rev?: string # Revision to mark bad
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
  run-external git bisect terms
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
