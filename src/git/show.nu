use ../wrapper.nu [
  commits,
]

use ../options.nu [
  color,
]

def diff_algorithm [] {
  [
    { value: "default", description: "Basic greedy diff algorithm (myers)" },
    { value: "histogram", description: "Patience that supports low-occurence common elements" },
    { value: "minimal", description: "Produce the smallest diff possible" },
    { value: "myers", description: "Basic greedy diff algorithm" },
    { value: "patience", description: "Best for generating patches" },
  ]
}

# Show various types of objects
export extern "git show" [
  ...object: string@commits               # Object to show
  --pretty: string                        # Pretty-print the contents of commit logs
  --format: string                        # Pretty-print the contents of commit logs
  --abbrev-commit                         # Show a prefix that names the object uniquely
  --no-abbrev-commit                      # Show the full commit name
  --oneline                               # Shortcut for --pretty=oneline --abbrev-commit
  --enocding: string                      # Transcode log messages
  --expand-tabs                           # Expand tabs to 8 spaces
  --expand-tabs: number                   # Expand tabs to this many spaces
  --no-expand-tabs                        # Disable tab expansions
  --notes: string                         # Show the notes that annotate the commit
  --no-notes                              # Do not show nodes
  --show-signature                        # Check signed commit validity
  --patch(-p)                             # Generate a patch
  -u                                      # Generate a patch
  --no-patch(-s)                          # Suppress diff output
  --diff-merges: string                   # Specify diff format for merge commits
  --no-diff-merges                        # Disable output of diffs for merge commits
  --combined-all-paths                    # List file name from all parents of combined diffs
  --unified(-U): number                   # Generate diffs with <n> lines of context
  --output: string                        # Output to a file
  --output-indicator-new: string          # Specify patch added line character
  --output-indicator-old: string          # Specify patch removed context line character
  --output-indicator-context: string      # Specify patch context line character
  --raw                                   # Show a summary of changes using raw diff format
  --patch-with-raw                        # Shortcut for -p --raw
  -t                                      # Show the tree objects in the diff output
  --indent-heuristic                      # Shift diff hunk boundaries to make patches easier to read
  --no-indent-heuristic                   # Disable the indent heuristic
  --minimal                               # Produce the smallest possible diff
  --patience                              # Use the "patience diff" algorithm
  --historgam                             # Use the "historgram diff" algorithm
  --anchored: string                      # Use the "anchored diff" algorithm
  --diff-algorithm: string@diff_algorithm # Choose a diff algorithm
  --stat: string                          # Generate a diffstat
  --compact-summary                       # Output a summary of extended header information
  --numstat                               # Like --stat, but more machine-friendly
  --shortstat                             # Only the last line of --stat
  --dirstat(-X): string                   # Output the distribution of relative change per sub-directory
  --cumulative                            # Shortcut for --dirstat=cumulative
  --dirstat-by-file: string               # Shortcut for --dirstt=files,…
  --summary                               # Output a condensed summary of extended header information
  --patch-with-stat                       # Shortcut for -p --stat
  -z                                      # Separate commits with NULs
  --name-only                             # Show only names of changed files
  --name-status                           # Show names and status of changed files
  --submodule: string                     # Specify how differences in submodules are shown
  --color: string@color                   # Show colored diff
  --no-color                              # Turn off colored diff
  --color-moved: string                   # Color moved lines differently
  --no-color-moved                        # Turn off move detection
  --color-moved-ws: string                # Configure how whitespace is ignored with move detection
  --no-color-moved-ws                     # Do not ignore whitespace when performing move detection
  --word-diff: string                     # Show a word diff
  --word-diff-regex: string               # Use <regex> to decide what a word is
  --color-words: string                   # Shortcut for --word-diff=color --word-diff-regex=<regex>
  --no-renames                            # Turn off rename detection
  --rename-empty                          # Use empty blobs as rename source
  --no-rename-empty                       # Do not use empty blobs as rename source
  --check                                 # Warn if changes introduce conflict markers or whitespace errors
  --ws-error-highlight: string            # Highlight whitespace errors
  --full-index                            # Show full pre- and post-image blob object names
  --binary                                # Output a binary diff for git-apply
  --abbrev: number                        # Show the shortest prefix of at least <n> hexdigits
  --break-rewrites(-B): string            # Break complete rewrite changes into delete/create pairs
  --find-renames(-M): number              # Detect and report renames for each commit
  --find-copies(-C): number               # Find copies as well as renames
  --find-copies-harder                    # Inspect unmodified files as source candidates
  --irreversible-delete(-D)               # Omit delete preimages
  -l: number                              # Limit rename and copy detection
  --diff-filter: string                   # Filter diff files
  -S: string                              # Look for differences in the occurance of <string>
  -G: string                              # Look for differences whose patch text contains <regex>
  --find-object: string                   # Look for differences in the occurance of <object>
  --pickaxe-all                           # When -S or -G finds a change show all changes
  --pickaxe-regex                         # Treat the -S string as a POSIX regular expression
  -O: string                              # Control the order of files in the output
  --skip-to: string                       # Discard files before the named file
  --rotate-to: string                     # Moves files before the named file to the end
  -R                                      # Swap the inputs
  --relative: string                      # Only show changes relative to <path>
  --no-relative                           # Show all changes
  --text(-a)                              # Treat all files as text
  --ignore-cr-at-eol                      # Ignore CR at EOL
  --ignore-space-at-eol                   # Ignore changes in whitespace at EOL
  --ignore-matching-lines(-I): string     # Ignore changes whose lines match <regex>
  --inter-hunk-context: number            # Show up to <n> lines of context between diff hunks
  --function-context(-W)                  # Show the whole function as change context
  --ext-diff                              # Allow an external diff helper
  --no-ext-diff                           # Disallow external diff helper
  --textconv                              # Allow external text conversion filters
  --no-textconv                           # Disallow external text conversion filters
  --ignore-submodules: string             # Ignore changes to submodules in diff generation
  --src-prefix: string                    # Use the given source prefix
  --dst-prefix: string                    # Use the given destination prefix
  --no-prefix                             # Do not show source or destination prefix
  --line-prefix: string                   # Prepend a this to every line
  --ita-invisible-in-index
  --ita-visible-in-index
  --help                                  # Show help
]


