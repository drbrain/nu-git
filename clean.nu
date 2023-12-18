# Remove untracked files from the working tree
export extern main [
  ...pathspec: path # Clean only these paths
  -d # Recurse into untracked directories
  --force(-f) # Delete untracked files
  --interactive(-i) # Show what would be done and clean files interactively
  --dry-run(-n) # Show what would be done
  --quiet(-q) # Only report errors
  --exclude(-e): string # Use this exclude pattern in addition to the standard ignore rules
  -x # Don't use the standard ignore rules
  -X # Remove only files ignored by git
]
