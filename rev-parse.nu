# Pick out and massage parameters
export extern main [
  ...args: string
  --parseopt              # Use git rev-parse option in parsing mode
  --keep-dashdash         # Echo first -- in --parseopt mode
  --stop-at-non-option    # Stop at the first non-option in --parseopt mode
  --stuck-long            # Output long options in --parseopt mode
  --sq-quote              # Use git rev-parse in shell quoting mode
  --revs-only             # Omit flags and parameters not meant for git rev-list
  --no-revs               # Omit flags and parameters meant for git rev-list
  --flags                 # Omit non-flag parameters
  --no-flags              # Omit flag parameters
  --default: string       # Use the argument as a default parameter
  --prefix: string        # Behave as if invoked from this subdirectory
  --verify                # Verify the parameter matches an object
  --quiet(-q)             # Do not output an error if verification fails
  --sq                    # Single line output for shell consumption
  --short                 # --verify with a shortened object name
  --short: number         # --verify with a shortened object name
  --not                   # Prepend object names with ^
  --abbrev-ref: string    # A non-ambiguous short name of the object's name
  --symbolic              # Output names as close to the original input as possible
  --symbolic-full-name    # --symbolic, but show full names for non-refs
  --all                   # Show all refs found
  --branches: string      # Show all branches matching this pattern
  --tags: string          # Show all tags matching this pattern
  --remotes: string       # Show all remotes matching this pattern
  --glob-pattern          # Show all refs matching this glob
  --exclude: string       # Exclude refs matching this glob
  --disambiguate: string  # Show all objects starting with this prefix
  --local-env-vars        # List GIT_ environment variables local to the repository
  --path-format: string   # Set the path format
  --git-dir               # Show $GIT_DIR or the path to the .git directory
  --git-common-dir        # Show $GIT_COMMON_DIR if defined, else $GIT_DIR
  --resolve-git-dir: path # Check if path is a valid repository or a gitfile that points at a repository
  --git-path: path        # Resolve $GIT_DIR/path accounting fro relocation variables
  --show-toplevel         # Show the path of the top-level directory of the working tree
  --show-superproject-working-tree # Show the root of the superproject's working tree
  --shared-path-index     # Show the path to the shared index file in split index mode
  --absolute-git-dir      # --git-dir with an absolute path
  --is-inside-git-dir     # Print true if the working directory is inside the repository directory
  --is-inside-work-tree   # Print true if the working directory is inside the repository
  --is-bare-repository    # Print true if the repository is bare
  --is-shallow-repository # Print true if the repository is shallow
  --show-cdup             # Show the path to the top-level directory from the current directory
  --show-prefix           # Show the path of the current directory relative to the top-level directory
  --show-object-format: string # Show the object format for storage inside the .git directory
  --since: string         # Show objects after this date
  --until: string         # Show objects before this date
]

# TODO: split into --parseopt and --sq-quote
