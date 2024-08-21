def decorate () {
  [
    [ value, description ];

    [ "auto", "Short ref names for TTY output" ]
    [ "full", "Include ref prefixes" ]
    [ "no", "Don't decorate" ]
    [ "short", "Omit refs/* prefixes" ]
  ]
}

# Show commit logs
export extern main [
  revision_range?: string     # Show commits in this revision range
  ...pathspec: path           # Show commits for these files
  --follow                    # Follow file renames
  --decorate: string@decorate # Print ref names of any commits that are shown
  --no-decorate               # Do not print ref names
  --clear-decorations         # Clear previous decoration options
  --source                    # Print the ref name from the command line by which each commit was reached
  --mailmap                   # Use mailmap file to map author and commiter names
  --no-mailmap                # Disable use of mailmap
  --use-mailmap               # Use mailmap file to map author and commiter names
  --no-use-mailmap            # Disable use of mailmap
  --full-diff                 # Show a full diff for commits that touch listed paths
  --log-size                  # Show the length of each commit's message in bytes
  -L: string                  # Trace the evolution of a line range
]

