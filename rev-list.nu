use options.nu [
  date
  exclude_hidden
]

# TODO: convert and remove
def human [] {
  [
    [value description];

    [human "Display a human-readable string"]
  ]
}

def walk [] {
  [
    [value description];

    [sorted "Reverse chronological order"]
    [unsorted "Order listed on the command line"]
  ]
}

# List commit objects in reverse chronological order
export extern main [
  ...commits_and_paths: string # Objects and paths
  --max-count(-n): number # Limit number of commits returned
  --skip: number # Skip commits before listing commits
  --since: string # List commits more recent than this
  --after: string # List commits more recent than this
  --since-as-filter: string # List all commits more recent than a specific date
  --until: string # List commits older than a specific date
  --before: string # List commits older than a specific date
  --max-age: string # Limit commits by date range
  --min-age: string # Limit commits by date range
  --author: string # List commits with this author
  --committer: string # List commits with this committer
  --grep-reflog: string # List commits with a matching reflog 
  --grep: string # List commits with a matching message
  --all-match # List commits that match all given --grep arguments
  --invert-grep # List commits that do not match --grep
  --regexp-ignore-case(-i) # Ignore case in pattern matching
  --basic-regexp # Patterns are basic regular expressions
  --extended-regexp(-E) # Patterns are extended regular expressions
  --fixed-strings(-F) # Patterns are fixed strings
  --perl-regexp(-P) # Patterns are Perl-compatible regular expressions
  --remove-empty # Stop when a path disappears from the tree
  --merges # List only merge commits
  --no-merges # Do not list commits with more than one parent
  --min-parents: number # List only commits with at least this many parents
  --max-parents: number # List only commits with at most this many parents
  --no-min-parents # Override --min-parents
  --no-max-parents # Override --max-parents
  --first-parent # Follow only the first parent of a merge commit
  --exclude-first-parent-only # Follow the first parent of a merge commit when excluding
  --not # Reverse the meaning of the `^` prefix for following revision specifiers
  --all # Pretend all refs and HEAD are listed on the command line
  --branches # Prentend all branches are listed on the command line
  --branches: string # Pretend all matching branches are listed on the command line
  --tags # Prentend all tags are listed on the command line
  --tags: string # Pretend all matching tags are listed on the command line
  --remotes # Prentend all remotes are listed on the command line
  --remotes: string # Pretend all matching remotes are listed on the command line
  --glob: string # Pretend all refs matching the glob pattern are listed on the command line
  --exclude: string # Do not include refs from --all, etc. that match the glob pattern 
  --exclude-hidden: string@exclude_hidden # Do not include refs that would be hidden by the given command
  --reflog # Pretend all objects mentioned by reflogs are listed on the command line
  --alternate-refs # Pretend all objects mentioned as ref tips of alternate repositories are listed on the command line
  --single-worktree # Examine only the current working tree for --all, --reflog, --indexed-objects
  --ignore-missing # Pretend invalid object names were not given
  --stdin # Also read argumenst from standard input
  --quiet # Don't print anything to standard output
  --disk-usage # Return the bytes used to store the selected objects
  --disk-usage: string@human # Return the bytes used to store the selected objects
  --cherry-mark # Like --cherry-pick, but mark equivalent commits with `=` and ineqivalent with `+`
  --cherry-pick # Omit any commit that introduces the same change as another commit on the "other side"
  --left-only # List only commits on the left side of a symmetric difference
  --right-only # List only commits on the right side of a symmetric difference
  --cherry # Synonym for --right-only --cherry-mark --no-merges
  --walk-reflogs(-g) # Walk reflog entries starting from most recent instead of commit ancestry
  --merge # After a failed merge, show refs that touch files having a conflict and don't exist on all heads to merge
  --boundary # Output excluded boundary commits
  --use-bitmap-index # Try to speed up traversal using the pack bitmap index
  --progress: string # List progress reports on stderr
  --simplify-by-decoration # Select commits that are referred to by a branch or tag
  --show-pulls # Include all commits from the default mode, but also any merge commits that are not TREESAME to the first parent but are TREESAME to a later parent
  --full-history # Default mode, but does not prune some history
  --dense # Only selected commits are shown, plus some to have a meaningful history
  --sparse # All commits in the simplified history are shown
  --simplify-merges # Remove needless merges from --full-history
  --ancestry-path # Only display commits in a range that are ancestors of the first commit in a range
  --ancestry-path: string # Only display commits in a range that are ancestors of this commit
  --bisect # Limit output to one commit roughly halfway between included and excluded commits
  --bisect-vars # Calculate --bisect without using refs/bisect/
  --bisect-all # Output all commit objects between included and excluded
  --date-order # List parents before all children, then timestamp order
  --author-date-order # List children before parents, then author timestamp order
  --topo-order # List children before parents and avoid showing commits on multiple lines of history intermixed
  --reverse # List commits in reverse order
  --objects # Print object IDs of objects referenced by the listed commits
  --in-commit-order # Print tree and blob ids in order of the commits
  --objects-edge # --objects, but list IDs of excluded commits prefixed with a `-`
  --objects-edge-aggressive # Try harder t ofind excluded commits than --objects-edge
  --indexed-objects # Pretend all trees and blobs used by the index are listed on the command line
  --unpacked # Print object IDs that are not in packs
  --object-names # Print the names of object IDs that are found
  --no-object-names # Do not print the names of object IDs that are found
  --filter: string # Omit matching objects from the returned objects
  --no-filter # Disable previous filters
  --filter-provided-objects # Filter the list of explicitly provided objects
  --filter-print-omitted # List objects omitted by the filter
  --missing: string # Debug option for a future "partial clone" operation
  --exclude-promisor-objects # Prefilter object traversal at promisor boundary
  --no-walk: string@walk # Only show the given commits, but do not traverse their ancestors
  --do-walk # Override --no-walk
  --pretty # Pretty-print
  --pretty: string # Pretty print with this format
  --format: string # Print with this format
  --abbrev-commit # Show a unique abbreviated prefix for the object name
  --no-abbrev-commit # Show the full object name
  --oneline # Shorthand for `--pretty=oneline --abbrev-commit`
  --encoding: string # Transcode commit log message
  --expand-tabs # Expand tabs to 8 spaces
  --expand-tabs: number # Expand tabs
  --no-expand-tabs # Disable tab expansion
  --show-signature # Check the validity of a signed commit
  --relative-date # Use times relative to now
  --date: string@date # Select date format for `--pretty`
  --header # Print commit contents in raw format
  --no-commit-header # Suppress the header line containing "commit" and the object ID
  --commit-header # Override --no-commit-header
  --parents # Also print commit parents
  --children # Also print commit children
  --timestamp # Print the raw commit timestamp
  --left-right # Mark which side of a symmetric difference a commit is reachable from
  --graph # Draw a graphical representatino of commit history
  --show-linear-break # Make history branches easier to read without `--graph`
  --show-linear-break: string # Make history branches easier to read without `--graph`
  --count # Return how many commits would be listed
]

# TODO: Separate bisection helpers
