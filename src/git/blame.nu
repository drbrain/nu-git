def date [] {
  [
    { value: "relative", description: "Relative to the current time" },
    { value: "local", description: "Weekday Month Day HH:MM:SS YYYY local TZ" },

    { value: "iso", description: "YYYY-MM-DD HH:MM:SS TZ" },
    { value: "iso-local", description: "YYYY-MM-DD HH:MM:SS local TZ" },
    { value: "iso8601", description: "YYYY-MM-DD HH:MM:SS TZ" },
    { value: "iso8601-local", description: "YYYY-MM-DD HH:MM:SS local TZ" },

    { value: "iso-strict", description: "YYYY-MM-DDTHH:MM:SS TZ" },
    { value: "iso8601-struct", description: "YYYY-MM-DDTHH:MM:SS TZ" },
    { value: "iso-strict", description: "YYYY-MM-DDTHH:MM:SS local TZ" },
    { value: "iso8601-struct", description: "YYYY-MM-DDTHH:MM:SS local TZ" },

    { value: "rfc", description: "Weekday, DD Month YYYY HH:MM:SS TZ" },
    { value: "rfc2822", description: "Weekday, DD Month YYYY HH:MM:SS TZ" },
    { value: "rfc-local", description: "Weekday, DD Month YYYY HH:MM:SS local TZ" },
    { value: "rfc2822-local", description: "Weekday, DD Month YYYY HH:MM:SS local TZ" },

    { value: "short", description: "YYY-MM-DD" },
    { value: "short-local", description: "YYY-MM-DD (in local TZ)" },

    { value: "raw", description: "Epoch seconds TZ" },
    { value: "raw-local", description: "Epoch seconds local TZ" },

    { value: "human", description: "Relative to the current time" },
    { value: "human-local", description: "Relative to the current time" },

    { value: "unix", description: "Epoch seconds" },
    { value: "unix-local", description: "Epoch seconds" },

    { value: "format:", description: "strftime format" },
    { value: "format-local:", description: "strftime format (in local TZ)" },

    { value: "default", description: "Weekday Month Day HH:MM:SS YYYY TZ" },
    { value: "default-local", description: "Weekday Month Day HH:MM:SS YYYY local TZ" },
  ]
}

# Show what revision and author last modified lines in a file
export extern "git blame" [
  file: path                 # File to show blame for
  -b                         # Show blank SHA for boundary commits
  --root                     # Do not treat root commits as boundaries
  --show-stats               # Include additional statistics
  -L: string                 # Annotate a line range or function name
  -l                         # Show long revision
  -t                         # Show raw timestamp
  -S: path                   # Use revisions from this file
  --reverse: string          # Walk history forward instead of backward
  --first-parent             # Follow only the first parent commit upon seeing a merge commit
  --porcelain(-p)            # Use porcelain format
  --line-porcelain           # Porcelain format with commit information for each line
  --incremental              # Show result incrementally
  --encoding: string         # Encoding for author names and commit summaries
  --contents: path           # Pretend the working tree copy has these contents
  --date: string@date        # Format to output date utils
  --progress                 # Report progress status
  --no-progress              # Do not report progress status
  -M: number                 # Detect lines moved within a file
  -C: number                 # Detect lines moved across files
  --ignore-rev: string       # Ignore changes from this revision
  --ignore-revs-file: path   # Ignore revisions from this file
  --color-lines              # Color line annotations by commit they come from
  --color-by-age             # Color line annotations by age
  -c                         # Use same output mode as git-annotate
  --score-debug              # Include debugging information related to movement of lines between files
  --show-name(-f)            # Show the filename in the original commit
  --show-number(-n)          # Show the line number in the original commit
  -s                         # Suppress author and timestamp
  --show-email(-e)           # Show author email instead of name
  -w                         # Ignore whitespace
  --abbrev: number           # Abbreviate commit SHA to this many characters
  --help(-h)                 # Show help
]


