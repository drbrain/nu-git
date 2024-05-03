# List references in a local repository
export extern main [
  ...pattern: string # Pattern of references to show
  --head # Show the HEAD reference even if it would be filtered out
  --dereference(-d) # Dereference tags into object IDs
  --hash(-s) # Only show the Object ID
  --hash(-s): number # Only show an abbreviated Object ID
  --abbrev # Abbreviate the object name
  --abbrev: number # Abbreviate the object name to this length
  --tags # Limit to refs/tags
  --heads # Limit to refs/heads
]

# Filter refs read from standard input
export def exclude-existing [
  pattern?: # Ignore pattern
] {
  let args = if $pattern {
    [ $"--exclude-existing=($pattern)" ]
  } else {
    [ $"--exclude-existing" ]
  }

  $in |
  run-external "git" "show-ref" $args
}

# Check whether a reference exists
export def exists [
  ref: string # Ref to check
] {
  run-external "git" "show-ref" "--exists" $ref

  match $env.LAST_EXIT_CODE {
    0 => {}
    1 => {
      error make {
        msg: "Reference lookup failure"
        label: {
          text: "error looking up this reference"
          span: (metadata $ref).span
        }
      }
    }
    2 => {
      error make {
        msg: "Missing reference"
        label: {
          text: "this reference does not exist"
          span: (metadata $ref).span
        }
      }
    }
    _ => {
      error make -u {
        msg: $"Other error \(($env.LAST_EXIT_CODE)\)"
        label: {
          text: "error looking up this reference"
          span: (metadata $ref).span
        }
      }
    }
  }
}

# Enable stricter reference checking by requiring an exact ref
export def verify [
  ...ref: string # Refs to verify
  --quiet(-q) # Do not print results to standard output
  --dereference(-d) # Dereference tags into object IDs
  --hash(-s) # Only show the Object ID
  --hash(-s): number # Only show an abbreviated Object ID
  --abbrev # Abbreviate the object name
  --abbrev: number # Abbreviate the object name to this length
] {
  mut args = [ "--verify" ]

  if $quiet { $args = ( $args | append "--quiet" ) }
  if $dereference { $args = ( $args | append "--dereference" ) }
  if $abbrev != null {
    if $abbrev == true {
      $args = ( $args | append "--abbrev" )
    } else {
      $args = ( $args | append $"--abbrev=($abbrev)" )
    }
  } 
  if $hash != null {
    if $hash == true {
      $args = ( $args | append "--hash" )
    } else {
      $args = ( $args | append $"--hash=($hash)" )
    }
  }

  let $args = $args | append $ref

  run-external "git" "show-ref" $args
}

