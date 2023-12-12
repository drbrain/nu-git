# Expanded from
# https://github.com/nushell/nushell/blob/main/crates/nu-utils/src/sample_config/default_config.nu
# which is covered by the MIT license

use wrapper.nu *
use options.nu *

export use git/add.nu *
export use git/blame.nu *
export use git/branch.nu *
export use git/checkout.nu *
export use git/cherry-pick.nu *
export use git/cleanup-repo.nu *
export use git/clone.nu *
export use git/commit.nu *
export use git/config.nu *
export use git/diff.nu *
export use git/fetch.nu *
export use git/fsck.nu *
export use git/gc.nu *
export use git/hist.nu *
export use git/init.nu *
export use git/log.nu *
export use git/ls-files.nu *
export use git/merge.nu *
export use git/mv.nu *
export use git/push.nu *
export use git/rebase.nu *
export use git/remote.nu *
export use git/restore.nu *
export use git/rev-parse.nu *
export use git/revert.nu *
export use git/rm.nu *
export use git/show.nu *
export use git/stash.nu *
export use git/status.nu *
export use git/submodule.nu *
export use git/switch.nu *
export use git/symbolic-ref.nu *
export use git/tag.nu *

def commands [] {
  ^git help -a
  | lines
  | where $it =~ "^   "
  | str trim
  | each { |it| parse -r '(?<value>[\w-]+)\s+(?<description>.*)' }
  | flatten
  | sort
}

# A revision control system
export extern main [
  command: string@commands
  args?: list
  --bare                 # Treat the repository as a bare repository
  --config-env: string   # Set configuration from an env var <name>=<envvar>
  --exec-path: string    # Path to core Git programs
  --git-dir: string      # Set path to the repository (".git" directory)
  --glob-pathspecs       # Add "glob" magic to all pathspecs
  --help                 # Show git help
  --html-path            # The path to Git's HTML documentation
  --icase-pathspecs      # Add "icase" magic to all pathspecs
  --info-path            # The path to Git's Info documentation
  --list-cmds: string    # List commands by group
  --literal-pathspecs    # Treat pathspecs literally (no globbing, etc.)
  --man-path             # The path to Git's manpath
  --namespace: string    # Set the git namespace
  --no-optional-locks    # Do not perform optional operations that require locks
  --no-pager(-P)         # Do not pipe output to a pager
  --no-replace-objects   # Do not use replacement refs to replace Git objects
  --noglob-pathspecs     # Add "literal" magic to all pathspecs
  --paginate(-p)         # Pipe all output to less (or $PAGER)
  --super-prefix: string # Set a prefix which gives a path from above a repository down to its root
  --version              # The git version
  --work-tree: string    # Set the path to the working tree
  -C: string             # Run as if the given path is CWD
  -c: string             # Set a configuration parameter <name>=<value>
]

