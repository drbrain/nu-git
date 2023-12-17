use wrapper.nu [
  git_files
  modified
]

def deletable [] {
  let modified = modified

  git_files
  | select name
  | rename value
  | merge $modified
  | sort
  | uniq-by value
}

# Remove files from the working tree and index
export extern main [
  ...pathspec: path@deletable # Files to remove
  --force(-f)                 # Override the up-to-date check
  --dry-run(-n)               # Don't remove files, just show if they would  be
  -r                          # Allow recursive removal of directories
  --cached                    # Unstage and removes paths only from the index
  --ignore-unmatch            # Exit with zero even if no files were matched
  --sparse                    # Allow updating index entries outside of the sparse-checkout
  --quiet(-q)                 # Suppress output
  --pathspec-from-file: path  # Read paths from file
  --pathspec-file-nul         # NUL separator for --pathspec-from-file
]

