# Show files in the index and/or working directory
export def main [
  ...files: path           # Files to show
  --cached(-c)             # Show all tracked files
  --deleted(-d)            # Show files with an unstaged deletion
  --others(-o)             # Show other (untracked) files
  --ignored(-i)            # Show only ignored files
  --stage(-s)              # Show staged contents
  --killed(-k)             # Show untracked files on the filesystem that need to be removed due to conflicts
  --modified(-m)           # Show files with an unstaged modification
  --abbrev: int            # Show the shortest unique prefix of at least N bytes
  --debug                  # Show debugging information for each file
  --directory              # If a directory is classified as "other" show just its name
  --eol                    # Show EOL info and attributes
  --error-unmatch          # If any file does not appear in the index treat this as an error
  --exclude(-x): string    # Exclude untracked files matching the pattern
  --exclude-from(-X): path # Read exclude patterns from file
  --exclude-standard       # Add the standard git exclusions
  --format: string         # Show formatted output
  --full-name              # Show paths relative to the project top directory
  --no-empty-directory     # Do not list empty directories
  --recurse-submodules     # Recursively call ls-files on submodules
  --resolve-undo           # Show files having resolve-undo information
  --sparse                 # With a sparse index, show the sparse directories without expanding to the contained files
  --unmerged(-u)           # Show information about unmerged files, but not any other tracked files
  --with-tree: string      # Prentend paths removed in the index since the tree-ish are still present
  -f                       # Show status tags with lowercase letters for "fsmonitor valid" files
  -t                       # Show status tags together with filenames
  -v                       # Show status tags with lowercase letters for "assume unchanged" files
  -z                       # Use NUL termination and unquoted filenames
] {
  mut name_only = false
  mut args = []

  if $abbrev != null {
    $args = ( $args | append ["--abbrev" $abbrev] )
  }

  if $cached {
    $args = ( $args | append ["--cached"] )
  }
 
  if $debug {
    $args = ( $args | append ["--debug"] )
  }

  if $deleted {
    $args = ( $args | append ["--deleted"] )
  }

  if $directory {
    $args = ( $args | append ["--directory"] )
  }

  if $eol {
    $name_only = true
    $args = ( $args | append ["--eol"] )
  }

  if $error_unmatch {
    $args = ( $args | append ["--error-unmatch"] )
  }

  if $exclude != null {
    $args = ( $args | append ["--exclude" $exclude] )
  }

  if $exclude_from != null {
    $args = ( $args | append ["--exclude-from" $exclude_from] )
  }

  if $full_name {
    $args = ( $args | append ["--full-name"] )
  }

  if $ignored {
    $args = ( $args | append ["--ignored"] )
  }

  if $killed {
    $name_only = true
    $args = ( $args | append ["--killed"] )
  }

  if $modified {
    $args = ( $args | append ["--modified"] )
  }

  if $no_empty_directory {
    $args = ( $args | append ["--no-empty-directory"] )
  }

  if $others {
    $name_only = true
    $args = ( $args | append ["--others"] )
  }

  if $recurse_submodules {
    $args = ( $args | append ["--recurse-submodules"] )
  }

  if $resolve_undo {
    $name_only = true
    $args = ( $args | append ["--resolve-undo"] )
  }

  if $sparse {
    $name_only = true
    $args = ( $args | append ["--sparse"] )
  }

  if $stage {
    $args = ( $args | append ["--stage"] )
  }

  if $unmerged {
    $args = ( $args | append ["--unmerged"] )
  }

  if $with_tree != null {
    $args = ( $args | append ["--with-tree" $with_tree] )
  }

  if $f {
    $args = ( $args | append ["-f"] )
  }

  if $t {
    $name_only = true
    $args = ( $args | append ["-t"] )
  }

  if $v {
    $args = ( $args | append ["-v"] )
  }

  if $z {
    $args = ( $args | append ["-z"] )
  }

  if $format != null {
    $args = ( $args | append ["--format" $format] )
  } else if not $name_only {
    $args = (
      $args
      | append [
          "--format",
          "%(path)%x00%(stage)%x00%(objecttype)%x00%(objectsize)"
        ]
      )
  }

  let args = $args

  if $format != null {
    GIT_PAGER=cat run-external "git" "ls-files" ...$args
  } else if $name_only {
    GIT_PAGER=cat run-external "git" "ls-files" ...$args
    | lines
    | wrap name
  } else {
    GIT_PAGER=cat run-external "git" "ls-files" ...$args
    | lines
    | each {|line| 
      $line
      | split column "\u{0}"
      | rename name stage type size
      | upsert size {|| $in.size | into filesize }
    }
    | flatten
  }
}


