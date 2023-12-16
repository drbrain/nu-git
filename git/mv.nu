# Move or rename files, directories, or symlinks
export extern "git mv" [
  source: path         # Source paths
  ...destination: path # Destination path
  --force(-f)          # Force renaming or moving of a file even if the target exists
  -k                   # Skip move or rename actions which would lead to an error condition
  --dry-run(-n)        # Do nothing; only show what would happen
  --verbose(-v)        # Report the names of files as they are moved
]

