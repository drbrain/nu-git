# Give an object a human-readable name based on an available ref
export extern main [
  ...commitish: string # Commit-ish objects to describe
  --dirty: string      # Describe the state of the working tree
  --all                # Instead using only annotated tags use any ref in refs/
  --tags               # Intsead of using only annotated tags use any tag in refs/tags
  --contains           # Find the tag that comes after the commit
  --abbrev: number     # Show the shortest prefix of at least <n> hexdigits
  --candidates: number # Consider up to this many candidates
  --exact-match        # Only output exact matches
  --debug              # Verbosely display information about the search strategy to stderr
  --long               # Always output the long format even when it matches a tag
  --match: string      # Only consider tags matching a glob pattern
  --exclude: string    # Do not consider tags matching a glob pattern
  --always             # Show uniquely abbreviated commit object as fallback
  --first-parent       # Follow only the first parent commit upon seeing a merge commit
]

