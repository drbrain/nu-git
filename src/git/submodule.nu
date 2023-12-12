def submodule [] {
  [
    "absorbgitdirs",
    "add",
    "deinit",
    "foreach",
    "init",
    "set-branch",
    "set-url",
    "status",
    "summary",
    "sync",
    "update",
  ]
}

# Initialize, update, or inspect submodules
export extern "git submodule" [
  command: string@submodule
  --quiet
  --cached
  --help                       # Show help
]

# Show the status of submodules
export def "git submodule status" (--recursive) {
  submodule_status $recursive
  | update SHA { |r| $r.SHA | str substring 0..8 }
  | sort
}

