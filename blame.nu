use options.nu [
  date
]

# Show what revision and author last modified lines in a file
export extern main [
  file: path               # File to show blame for
  -b                       # Show blank SHA for boundary commits
  --root                   # Do not treat root commits as boundaries
  --show-stats             # Include additional statistics
  -L: string               # Annotate a line range or function name
  -l                       # Show long revision
  -t                       # Show raw timestamp
  -S: path                 # Use revisions from this file
  --reverse: string        # Walk history forward instead of backward
  --first-parent           # Follow only the first parent commit upon seeing a merge commit
  --porcelain(-p)          # Use porcelain format
  --line-porcelain         # Porcelain format with commit information for each line
  --incremental            # Show result incrementally
  --encoding: string       # Encoding for author names and commit summaries
  --contents: path         # Pretend the working tree copy has these contents
  --date: string@date      # Format to output date utils
  --progress               # Report progress status
  --no-progress            # Do not report progress status
  -M: number               # Detect lines moved within a file
  -C: number               # Detect lines moved across files
  --ignore-rev: string     # Ignore changes from this revision
  --ignore-revs-file: path # Ignore revisions from this file
  --color-lines            # Color line annotations by commit they come from
  --color-by-age           # Color line annotations by age
  -c                       # Use same output mode as git-annotate
  --score-debug            # Include debugging information related to movement of lines between files
  --show-name(-f)          # Show the filename in the original commit
  --show-number(-n)        # Show the line number in the original commit
  -s                       # Suppress author and timestamp
  --show-email(-e)         # Show author email instead of name
  -w                       # Ignore whitespace
  --abbrev: number         # Abbreviate commit SHA to this many characters
]

