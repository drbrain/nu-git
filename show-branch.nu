use options.nu [
  color
]

# Show branches and their commits
export extern main [
  ...rev_or_globs: string # Revisions to show ancestry for
  --all(-a) # Show remote-tracking branches and local branches
  --remotes(-r) # Show remote-tracking branches
  --current # Include the current branche in the revs shown
  --topo-order # Show child commits before parents
  --date-order # Show child commits before parents, then by commit date
  --sparse # Make merges that are reachable from only one tip visible
  --more: number # Go this many commits past a common ancestor.  When negative do not show the ancestry tree
  --list # --more=-1
  --merge-base # Determine possible merge bases for the given commits
  --independent # Display only refs that cannot be reached from any other ref
  --no-name # Do not show commit naming strings
  --sha1-name # Name commits with the object name unique prefix
  --topics # Only show commits that are not on the first branch given
  --reflog(-g) # Show most-recent ref-log entries for the given ref
  --reflog(-g): string # Show most-recent ref-log entries for the given ref
  --color # Color the status signs according to the branch its in
  --color: string@color # Color the status signs according to the branch its in
  --no-color # Turn off color output
]
