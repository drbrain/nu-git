use options.nu [
  color
  color_moved
  color_moved_ws
  diff_algorithm
  diff_submodule
  diff_word
  ws_error
]

use wrapper.nu [
  local_branches
  modified
]

# Show changes between commits, commit and tree, etc.
export extern main [
  branch?: string@local_branches
  ...pathspec: path@modified              # Files to diff
  --cached                                # View staged chages relative to a commit
  --staged                                # View staged chages relative to a commit
  --merge-base                            # View working tree changes relative to a commit
  --no-index                              # Compare two paths on the filesystem
  --patch(-p)                             # Generate a patch
  -u                                      # Generate a patch
  --no-patch(-s)                          # Suppress all diff output
  --unified(-U): number                   # Generate diffs with lines of context
  --output: path                          # Output to a file
  --output-indicator-new: string          # New line indicator
  --output-indicator-old: string          # Old line indicator
  --output-indicator-context: string      # Context line indicator
  --raw                                   # Generate a raw diff
  --path-with-raw                         # Synonym for -p --raw
  --indent-heuristic                      # Shift diff hunk boundaries to make patches easier to read (default)
  --no-indent-heuristic                   # Disable indent heuristic
  --minimal                               # Spend extra time to amke small diffs
  --patience                              # Use the "patience diff" algorithm
  --histogrom                             # Use the "histogram diff" algorithm
  --anchored: string                      # Use the "anchored diff" algorithm
  --diff-algorithm: string@diff_algorithm # Selects the diff algorithm
  --stat: string                          # Generate a diffstat
  --compact-summary                       # Output a condensed summary of extended header information
  --numstat                               # Diffstat with added and deleted lines as numbers and pathnames without abbreviations
  --shortstat                             # Only the last line of diffstat
  --dirstat(-X): string                   # Output the distribution of relative amount of change for each sub-directory
  --cumulative                            # Shortcut for --dirstat=cumulative
  --dirstat-by-file: string               # Shortcut for --dirstt=files,…
  --summary                               # Output a condensed summary of extended header information
  --patch-with-stat                       # Shortcut for -p --stat
  -z                                      # Separate commits with NULs
  --name-only                             # Show only names of changed files
  --name-status                           # Show names and status of changed files
  --submodule: string@diff_submodule      # Specify how differences in submodules are shown
  --color: string@color                   # Show colored diff
  --no-color                              # Turn off colored diff
  --color-moved: string@color_moved       # Color moved lines differently
  --no-color-moved                        # Turn off move detection
  --color-moved-ws: string@color_moved_ws # Configure how whitespace is ignored with move detection
  --no-color-moved-ws                     # Do not ignore whitespace when performing move detection
  --word-diff: string@diff_word           # Show a word diff
  --word-diff-regex: string               # Use <regex> to decide what a word is
  --color-words: string                   # Shortcut for --word-diff=color --word-diff-regex=<regex>
  --no-renames                            # Turn off rename detection
  --rename-empty                          # Use empty blobs as rename source
  --no-rename-empty                       # Do not use empty blobs as rename source
  --check                                 # Warn if changes introduce conflict markers or whitespace errors
  --ws-error-highlight: string@ws_error   # Highlight whitespace errors
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
  -O: path                                # Control the order of files in the output
  --skip-to: path                         # Discard files before the named file
  --rotate-to: path                       # Moves files before the named file to the end
  -R                                      # Swap the inputs
  --relative: path                        # Only show changes relative to <path>
  --no-relative                           # Show all changes
  --text(-a)                              # Treat all files as text
  --ignore-cr-at-eol                      # Ignore CR at EOL
  --ignore-space-at-eol                   # Ignore changes in whitespace at EOL
  --ignore-space-change(-b)               # Ignore changes in amount of whitespace
  --ignore-all-space(-w)                  # Ignore whitespace when comparing lines
  --ignore-blank-lines                    # Ignore all-blank lines
  --ignore-matching-lines(-I): string     # Ignore changes whose lines match <regex>
  --inter-hunk-context: number            # Show up to <n> lines of context between diff hunks
  --function-context(-W)                  # Show the whole function as change context
  --exit-code                             # Use an exit code similar to diff
  --quiet                                 # Disable all output
  --ext-diff                              # Allow an external diff helper
  --no-ext-diff                           # Disallow external diff helper
  --textconv                              # Allow external text conversion filters
  --no-textconv                           # Disallow external text conversion filters
  --ignore-submodules: string             # Ignore changes to submodules in diff generation
  --src-prefix: string                    # Use the given source prefix
  --dst-prefix: string                    # Use the given destination prefix
  --no-prefix                             # Do not show source or destination prefix
  --line-prefix: string                   # Prepend a this to every line
  --ita-invisible-in-index                # Change how `git add -N` files are visible
  --ita-visible-in-index                  # Use the default visibility of `git add -N` files
  --base(-1)                              # Compare the working tree with the base (when resolving conflicts)
  --ours(-2)                              # Compare the working tree with our branch (when resolving conflicts)
  --theirs(-3)                            # Compare the working tree with their branch (when resolving conflicts)
  -0                                      # Omit diff output for unmerged entries
]

# TODO: Split --cached, etc. into separate commands
