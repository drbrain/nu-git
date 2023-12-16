# Prune all unreachable objects from the object database
export extern "git prune" [
  ...head: string  # Keep objects reachable from these heads
  --dry-run(-n)    # Report what would be removed
  --verbose(-v)    # Report all removed objects
  --progress       # Show progress
  --expire: string # Only expire loose objects older than this
]
