use wrapper.nu [
  commits,
  modified,
]

# Copy entries from treeish to the index
export extern main [
  treeish                    # State to reset to
  ...pathspec: path@modified # Paths to reset
  --quiet(-q)                # Supress feedback
  --pathspec-file-nul        # NUL separator for --pathspec-from-file
  --pathspec-from-file: path # Read <pathspec> from this file
]

# Interactively reset hunks between the index and treeish
export def patch [
  treeish?                   # State to reset to
  ...pathspec: path@modified # Paths to reset
] {
  let treeish = if ($treeish == null) {
    "HEAD"
  } else {
    $treeish
  }

  ^git reset --patch $treeish -- $pathspec
}

# Reset the index and the working tree, discarding changes to tracked files
export def hard [
  commit: string@commits # Commit to reset to
  --quiet(-q)            # Supress feedback
] {
  mut args = ["--hard"]

  if $quiet {
    $args = ( $args | append ["--quiet"] )
  }

  let args = ( $args | append [$commit] )

  ^git reset $args
}

# Reset the index and update files in the working tree between <commit> and
# HEAD
export def keep [
  commit: string@commits # Commit to reset to
  --quiet(-q)            # Supress feedback
] {
  mut args = ["--keep"]

  if $quiet {
    $args = ( $args | append ["--quiet"] )
  }

  let args = ( $args | append [$commit] )

  ^git reset $args
}

# Reset the index and update files in the working tree that are different
# between <commit> and HEAD, but keep those that are different between the
# index and the working tree
export def merge [
  commit: string@commits # Commit to reset to
  --quiet(-q)            # Supress feedback
] {
  mut args = ["--merge"]

  if $quiet {
    $args = ( $args | append ["--quiet"] )
  }

  let args = ( $args | append [$commit] )

  ^git reset $args
}

# Reset the index but not the working tree
export def mixed [
  commit: string@commits # Commit to reset to
  --quiet(-q)            # Supress feedback
  -N                     # Remove paths are marked as intent-to-add
] {
  mut args = ["--mixed"]

  if $quiet {
    $args = ( $args | append ["--quiet"] )
  }

  if $N {
    $args = ( $args | append ["-N"] )
  }

  let args = ( $args | append [$commit] )

  ^git reset $args
}

# Reset without touching the index file or working tree at all
export def soft [
  commit: string@commits # Commit to reset to
  --quiet(-q)            # Supress feedback
] {
  mut args = ["--soft"]

  if $quiet {
    $args = ( $args | append ["--quiet"] )
  }

  let args = ( $args | append [$commit] )

  ^git reset $args
}

