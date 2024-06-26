use options.nu [
  color
  column
]

use wrapper.nu [
  commits
  git_tags
]

def tags [] {
  git_tags
  | rename "value" "description"
}

def cleanup_mode [] {
  [
    [value description];

    ["verbatim"   "Do not change the message"]
    ["whitespace" "Remove leading and trailing whitespace lines"]
    ["strip"      "Remove leading and trailing whitespace and comments"]
  ]
}

# Create, list, delete, or verify a tag object
export def main [] {
  help git tag
}

# Create tag
export def create [
  tagname: string                # New tag name
  commit?: string@commits        # Commit to tag
  --annotate(-a)                 # Make an unsigned, annotated tag object
  --cleanup: string@cleanup_mode # Specify how the tag message is cleaned up
  --edit(-e)                     # Edit message read from --file
  --file(-F): path               # Read message from file
  --force(-f)                    # Replace an existing tag
  --local-user(-u): string       # Use this key to make a GPG-signed tag
  --message(-m): string          # Set the tag message
  --no-sign                      # Disable GPG-signing
  --sign(-s)                     # Make a GPG-signed tag
] {
  mut args = []

  if $annotate { $args = ( $args | append "--annotate" ) }
  if $edit { $args = ( $args | append "--edit" ) }
  if $file != null { $args = ( $args | append ["--file" $file] ) }
  if $force { $args = ( $args | append "--force" ) }
  if $local_user != null { $args = ( $args | append ["--local-user" $local_user] ) }
  if $message != null { $args = ( $args | append ["--message" $message] ) }
  if $no_sign { $args = ( $args | append "--no-sign" ) }
  if $sign { $args = ( $args | append "--sign" ) }

  $args = ( $args | append [$tagname] )
  if $commit != null { $args = ( $args | append [$commit] ) }

  let args = $args

  GIT_PAGER=cat run-external "git" "tag" ...$args
}

# Delete tags
export def delete [
  ...tagname: string@tags # Tags to delete
] {
  run-external "git" "tag" "--delete" ...$tagname
}

# List tags
export def list [
  ...pattern: string            # Tag patterns to match
  -n: number                    # Print lines from an annotation
  --column: string@column       # Display tag list in columns
  --color: string@color         # Respect colors in --format output
  --contains: string@commits    # List tags with the given commit
  --create-reflog               # Create a reflog for the tag
  --format: string              # Format tag output
  --ignore-case(-i)             # Ignore case when sorting and filtering
  --merged: string              # List tags reachable from the given commit
  --no-column                   # Do not show columns
  --no-contains: string@commits # List tags without the given commit
  --no-merged: string@commits   # List tags not reachable from the given commit
  --points-at: string@commits   # List tags of the given object
  --sort: string                # Sort by key
] {
  mut args = [ "--list" ]

  if $n != null { $args = ( $args | append [ "-n" $n ]) }
  if $column != null { $args = ( $args | append [ "--column" $column ]) }
  if $contains != null { $args = ( $args | append [ "--contains" $contains ]) }
  if $create_reflog != null { $args = ( $args | append "--create-reflog" ) }
  if $format != null {
    $args = ( $args | append [ "--format" $format ] )

    if $color != null {
      $args = ( $args | append [ "--color" $color ] )
    }
  } else {
    $args = ( $args | append [ "--format" "%(refname:strip=2)%00%(contents:subject)" ])
  }

  if $ignore_case { $args = ( $args | append "--ignore-case" ) }
  if $merged != null { $args = ( $args | append [ "--merged" $merged ]) }
  if $no_column != null { $args = ( $args | append "--no-column" ) }
  if $no_contains != null { $args = ( $args | append [ "--no_contains" $no_contains ]) }
  if $no_merged != null { $args = ( $args | append [ "--no-merged" $no_merged ]) }
  if $points_at != null { $args = ( $args | append [ "--points-at" $points_at ]) }
  if $sort != null { $args = ( $args | append [ "--sort" $sort ]) }

  let args = ( $args | append $pattern )

  let result = run-external "git" "tag" ...$args

  if $format == null {
    $result
    | lines
    | each {||
      $in
      | split column "\u{0}"
    }
    | flatten
    | rename tag subject
  } else {
    $result
  }
}

# Verify GPG signatures of tags
export def verify [
  ...tagname: string@tags # Tags to verify
  --format: string        # Format tag output
] {
  let format = if $format != null {
    "%(refname:strip=2)%00%(contents:subject)"
  } else {
    $format
  }

  let args = [
    "--verify"
    "--format" $format
    $tagname
  ]

  GIT_PAGER=cat run-external "git" "tag" ...$args
}

