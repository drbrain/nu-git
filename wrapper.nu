# Completion for branches and remotes
export def branches_and_remotes [] {
  git_remotes
  | select name url
  | rename value description
  | append (
    git_local_branches | select name | rename value
  )
  | append (
    git_remote_branches | select name
    | rename value
  )
  | uniq
  | sort
}

# Get config value and type
export def config_get [
  name: string  # Config name
  type?: string # Value type
] {
  mut args = [
    "--local"
    "--get"
  ]

  if $type != null { $args = ( $args | append [ "--type" $type ]) }

  let args = $args | append $name

  let value = try {
    run-external --redirect-combine --trim-end-newline "git" "config" $args
  } catch {
    let error = match $env.LAST_EXIT_CODE {
      1 => {
        error make {
          msg: "Config entry not found"
          label: {
            text: "name"
            span: (metadata $name).span
          }
        }
      }
      127 => {
        error make {
          msg: "Config type mismatch"
          label: {
            text: $"($name) is not this type"
            span: (metadata $type).span
          }
        }
      }
      _ => {
        error make {
          msg: "Unknown error getting config entry"
        }
      }
    }

    return $error
  }

  if ( $value | is-empty ) {
    return null
  }

  match $type {
    "bool" => {
      $value | into bool
    }
    "bool-or-int" => {
      if $value =~ '\d' {
        $value | into  int
      } else {
        $value | into bool
      }
    }
    "expiry-date" => {
      $value | into datetime
    }
    "int" => {
      $value | into int
    }
    _ => {
      $value | into string
    }
  }
}

# Completion for branches in the local repository
export def local_branches [] {
  git_local_branches
  | select name
  | rename value
  | uniq
  | sort
}

# Completion for files modified in the index
export def modified [] {
  git_status false
  | select name status
  | rename value description
}

# Completion for branches in remote repositories
export def remote_branches [] {
  git_remote_branches
  | select name url
  | rename value description
  | uniq
  | sort
}

def commits_parse_line [line: string] {
  ( $line
  | split column "\u{0}"
  | rename ref author date subject
  | upsert date {|| $in.date | into datetime }
  )
}

export def git_commits [--hash-format: string = "%h", --max-count: int] {
  let args = [
    "log",
    $"--pretty=format:($hash_format)%x00%an%x00%aI%x00%s",
    $"--max-count=($max_count)",
  ]

  ( GIT_PAGER=cat run-external --redirect-stdout "git" $args
  | lines
  | each { |line| commits_parse_line $line }
  | flatten
  )
}

# The path to the .git repository
export def git_dir [] {
  try {
    run-external --redirect-stdout --trim-end-newline "git" "rev-parse" "--absolute-git-dir"
    | into string
    | str trim --right
  } catch {
    error make --unspanned {
      msg: "Not in a git directory"
    }
  }
}

# Commits for completion
export def commits [] {
  let max_count = try {
    config_get "completion-nu.max-commits" int
  } catch {
    100
  }

  git_commits --max-count $max_count
  | insert description {||
      $"($in.subject) \(($in.author), ($in.date | date humanize)\)"
  }
  | select ref description
  | rename value description
}

export def ls_files_parse [line: string] {
  ( $line
  | split column "\u{0}"
  | rename name stage type size object_name
  )
}

export def git_files [] {
  let args = [
    "ls-files",
    "--format=%(path)%x00%(stage)%x00%(objecttype)%x00%(objectsize)%x00%(objectname)",
  ]

  ( GIT_PAGER=cat run-external --redirect-stdout "git" $args
  | lines
  | each {|line| ls_files_parse $line }
  | flatten
  )

}

def for_each_ref [filter] {
  run-external --redirect-stdout "git" "for-each-ref" "--format=%(refname:lstrip=2)%00%(objectname)" $filter
  | lines
}

# Local branches and commits
export def git_local_branches [] {
  for_each_ref "refs/heads/"
  | parse "{name}\u{00}{commit}"
}

# Remotes for the current repository
export def git_remotes [] {
  run-external --redirect-stdout "git" "remote" "-v"
  | lines
  | parse "{name}\t{url} ({type})"
}

# Completios for remotes for the current directory
export def remotes [] {
  git_remotes
  | select name url
  | rename value description
  | uniq
  | sort
}

# Local branches and commits
export def git_remote_branches [] {
  for_each_ref "refs/remotes/"
  | lines
  | parse "{remote}/{name}\u{00}{commit}"
  | move remote --after name
}

# Parses most of `git status --porcelain=2`
#
# This does not parse the `<sub>` field containing the submodule status
#
# This does not parse the `<X><score>` field containing the rename/copy similarity status
def parse_line [] {
  let line = $in | split row " "
  let status = $line.0

  match $status {
    "?" => {
      {
        name: $line.1
        status: "untracked"
        staged: "untracked"
        unstaged: "untracked"
      }
    },
    "!" => {
      {
        name: $line.1
        status: "ignored"
        staged: "untracked"
        unstaged: "untracked"
      }
    }
    "1" => {
      let states = $line.1 | parse_states

      {
        name: $line.8
        status: changed
        staged: $states.staged
        unstaged: $states.unstaged
        mode_head: $line.3
        mode_index: $line.4
        mode_worktree: $line.5
        name_head: $line.6
        name_index: $line.7
      }
    }
    "2" => {
      let paths = parse_rename_path $line.9
      let states = $line.1 | parse_states

      {
        status: "renamed"
        name: $paths.0
        staged: $states.staged
        unstaged: $states.unstaged
        mode_head: $line.3
        mode_index: $line.4
        mode_worktree: $line.5
        name_head: $line.6
        name_index: $line.7
        original_name: $paths.1
      }
    },
    "u" => {
      let states = $line.1 | parse_states

      {
        status: "unmerged"
        name: $line.10
        staged: $states.staged
        unstaged: $states.unstaged
        mode_stage_1: $line.3
        mode_stage_2: $line.4
        mode_stage_3: $line.5
        mode_worktree: $line.6
        name_stage_1: $line.7
        name_stage_2: $line.8
        name_stage_3: $line.9
      }
    }
  }
}

# Paths for a rename record are separated by a tab character
def parse_rename_path [paths: string] {
  ( $paths
  | split row "\t" )
}

# State marker
def parse_state [] {
  match $in {
    "." => { "unmodified" }
    "M" => { "modified" }
    "T" => { "type changed" }
    "A" => { "added" }
    "D" => { "deleted" }
    "R" => { "renamed" }
    "C" => { "copied" }
    "U" => { "updated" }
  }
}

# States field contains the staged and unstaged status of an object
def parse_states [] {
  let states = $in | split chars

  let staged = $states.0 | parse_state
  let unstaged = $states.1 | parse_state

  {
    staged: $staged
    unstaged: $unstaged
  }
}

export def git_status [ignored: bool] {
  mut args = [ "--porcelain=2" ]
  if ($ignored | into bool) { $args = ( $args | append "--ignored" ) }

  let args = $args

  run-external --redirect-stdout "git" "status" $args
  | lines
  | each {||
    $in | parse_line
  }
}

def stash_list_parse_line [line: string] {
  ( $line
  | split column "\u{0}"
  | rename date subject
  | update subject { |r|
    $r.subject
    | parse -r "WIP on (?P<branch>.*?): (?P<commit>\\w+) (?P<subject>.*)"
  }
  | flatten -a
  )
}

export def stash_list [] {
  let args = [
    "reflog",
    "stash"
    "--pretty=format:%aI%x00%s",
  ]

  ( GIT_PAGER=cat run-external --redirect-stdout "git" $args
  | lines
  | par-each { |line| stash_list_parse_line $line }
  | flatten
  )
}

def submodule_status_parse_line [line: string] {
  ( $line
  | parse -r '(?P<status>[ U+-])(?P<SHA>[^ ]+) (?P<path>.*?) \((?P<ref>.*)\)'
  | move status --after ref
  | move path --before SHA
  | move ref --before SHA
  )
}

export def submodule_status [recursive: bool] {
  let args = [
    "submodule",
    "status"
  ]

  let args = if $recursive {
    $args | append "--recursive"
  } else {
    $args
  }

  # TODO: Read .gitmodules and run git -C $submodule rev-parse HEAD to find
  # commits and be recursive
  ( GIT_PAGER=cat run-external --redirect-stdout "git" $args
  | lines
  | par-each { |line| submodule_status_parse_line $line }
  | flatten
  )
}

export def git_tags [] {
  let args = [
    "tag",
    "--list"
    "--format"
    "%(refname:strip=2)%00%(contents:subject)"
  ]

  GIT_PAGER=cat run-external --redirect-stdout "git" $args
  | lines
  | each {||
    $in
    | split column "\u{0}"
  }
  | flatten
  | rename tag subject
}
