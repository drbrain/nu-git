use ../wrapper.nu [
  modified,
]

export def chmod [] {
  [
    { value: "+x", description: "Set the executable bit" },
    { value: "-x", description: "Clear the executable bit" },
  ]
}

# Add file contents to the index
export extern "git add" [
  ...pathspec: path@modified # Paths to add to the index
  --all(-A)                  # Update the index where the working tree has a matching file or index entry
  --chmod: string@chmod      # Override the executable bit of added files
  --dry-run(-n)              # Don't add files, just show if the exist or will be ignored
  --edit(-e)                 # Open the diff against the index in an editor
  --force(-f)                # Allow adding ignored files
  --ignore-errors            # Ignore errors when indexing files
  --ignore-missing           # Only with --dry-run, check if files would be ignored
  --ignore-removal           # Add files unknown to the index and modified files, but no removed files
  --intent-to-add(-N)        # Record that the path will be added later
  --interactive(-i)          # Add modified contents in the working tree interactively to the index
  --no-all                   # See --ignore-removal
  --no-ignore-removal        # See as --all
  --no-warn-embedded-repo    # Do not warn about an embedded repository
  --patch(-p)                # Interactively add hunks of patch between the index and the work tree
  --pathspec-file-nul        # NUL separator for --path-spec-from-file
  --pathspec-from-file: path # Read <pathspec> from this file
  --refresh                  # Refresh file stat() information in the index
  --renormalize              # Forcibly add tracked files to the index again
  --sparse                   # Allow updating index entries outside of the sparse-checkout cone
  --update(-u)               # Update the index just where it already has an entry matching <pathspec>
  --verbose(-v)              # Be verbose
  --help                     # Show help
]


