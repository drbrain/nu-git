use wrapper.nu [
  local_branches
  remotes
]

def recurse [] {
  [
    { value: "check", description: "Verify submodule commits are pushed" }
    { value: "on-demand", description: "Push changed submodules" }
    { value: "only", description: "Push only submodules" }
    { value: "no", description: "Do not push submodules" }
  ]
}

def signed [] {
  [
    { value: "true", description: "Fail if signed pushes are not supported" }
    { value: "false", description: "Do not attempt signing" }
    { value: "if-asked", description: "Sign if supported by the server" }
  ]
}

# Update remote refs along with associated objects
export extern main [
  remote?: string@remotes              # The remote to push to
  refspec?: string@local_branches      # The branch to push
  --verbose(-v)                        # be more verbose
  --quiet(-q)                          # be more quiet
  --repo: string                       # repository
  --all                                # push all refs
  --mirror                             # mirror all refs
  --delete(-d)                         # delete refs
  --tags                               # push tags (can't be used with --all or --mirror)
  --dry-run(-n)                        # dry run
  --porcelain                          # machine-readable output
  --force(-f)                          # force updates
  --force-with-lease: string           # require old value of ref to be at this value
  --recurse-submodules: string@recurse # control recursive pushing of submodules
  --thin                               # use thin pack
  --receive-pack: string               # receive pack program
  --exec: string                       # receive pack program
  --set-upstream(-u)                   # set upstream for git pull/status
  --progress                           # force progress reporting
  --prune                              # prune locally removed refs
  --no-verify                          # bypass pre-push hook
  --follow-tags                        # push missing but relevant tags
  --signed: string                     # GPG sign the push
  --no-signed                          # Do not attempt GPG signing
  --atomic                             # request atomic transaction on remote side
  --push-option(-o): string            # option to transmit
  --ipv4(-4)                           # use IPv4 addresses only
  --ipv6(-6)                           # use IPv6 addresses only
]

