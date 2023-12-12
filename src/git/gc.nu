# Clean and optimize the local repository
export extern "git gc" [
  --aggressive        # Optimize more agressively and take more time
  --auto              # Check if housekeeping is required and exit if none is required
  --cruft             # Pack unreachable objects into a cruft pack instead of as loose objects
  --force             # Force gc run even if another gc may be running
  --keep-largest-pack # Consolidate most packs
  --no-cruft          # Leave unreachable objects loose
  --no-prune          # Do not prune loose objects
  --prune: string     # Prune loose objects older than this date
  --quiet             # Suppress output
]

