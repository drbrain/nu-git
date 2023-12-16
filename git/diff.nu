use ../wrapper.nu [
  local_branches,
  modified,
]

# Show changes between commits, commit and tree, etc.
export extern "git diff" [
  branch?: string@local_branches
  ...pathspec: path@modified          # Files to diff
  --cached
  --merge-base
  --staged
  --patch(-p)                # Interactively add hunks of patch between the index and the work tree
  -u
  --no-patch(-s)
  --unified(-U): number
  --ignore-all-space(-w)
  --ignore-blank-lines
  --ignore-cr-at-eol         # Ignore CR at EOL
  --ignore-space-at-eol      # Ignore changes in whitespace at EOL
  --ignore-space-change(-b)
  --quiet
]

# TODO: Split --cached, etc. into separate commands
