# Expanded from
# https://github.com/nushell/nushell/blob/main/crates/nu-utils/src/sample_config/default_config.nu
# which is covered by the MIT license

export module add.nu
export use add

export use bisect.nu *

export module blame.nu
export use blame

export module branch.nu
export use branch

export module checkout.nu
export use checkout

export module cherry-pick.nu
export use cherry-pick

export module clean.nu
export use clean

export module cleanup-repo.nu
export use cleanup-repo

export module clone.nu
export use clone

export module commit.nu
export use commit

export module config.nu
export use config

export module describe.nu
export use describe

export module diff.nu
export use diff

export module difftool.nu
export use difftool

export module fetch.nu
export use fetch

export module fsck.nu
export use fsck

export module gc.nu
export use gc

export module help.nu
export use help

export module hist.nu
export use hist

export module init.nu
export use init

export module log.nu
export use log

export module ls-files.nu
export use ls-files

export use merge.nu *

export module mv.nu
export use mv

export module prune.nu
export use prune

export module pull.nu
export use pull

export module push.nu
export use push

export use rebase.nu *

export module remote.nu
export use remote

export module reset.nu
export use reset

export module restore.nu
export use restore

export module rev-list.nu
export use rev-list

export module rev-parse.nu
export use rev-parse

export use revert.nu *

export module rm.nu
export use rm

export module show.nu
export use show

export module show-branch.nu
export use show-branch

export module show-ref.nu
export use show-ref

export module stash.nu
export use stash

export module status.nu
export use status

export module submodule.nu
export use submodule

export module switch.nu
export use switch

export module symbolic-ref.nu
export use symbolic-ref

export module tag.nu
export use tag

# A revision control system
export def main [] {
  help git
}

# def commands [] {
#   ^git help -a
#   | lines
#   | where $it =~ "^   "
#   | str trim
#   | each { |it| parse -r '(?<value>[\w-]+)\s+(?<description>.*)' }
#   | flatten
#   | sort
# }
#
# export extern main [
#   command: string@commands
#   args?: list
#   --bare                 # Treat the repository as a bare repository
#   --config-env: string   # Set configuration from an env var <name>=<envvar>
#   --exec-path: string    # Path to core Git programs
#   --git-dir: string      # Set path to the repository (".git" directory)
#   --glob-pathspecs       # Add "glob" magic to all pathspecs
#   --help                 # Show git help
#   --html-path            # The path to Git's HTML documentation
#   --icase-pathspecs      # Add "icase" magic to all pathspecs
#   --info-path            # The path to Git's Info documentation
#   --list-cmds: string    # List commands by group
#   --literal-pathspecs    # Treat pathspecs literally (no globbing, etc.)
#   --man-path             # The path to Git's manpath
#   --namespace: string    # Set the git namespace
#   --no-optional-locks    # Do not perform optional operations that require locks
#   --no-pager(-P)         # Do not pipe output to a pager
#   --no-replace-objects   # Do not use replacement refs to replace Git objects
#   --noglob-pathspecs     # Add "literal" magic to all pathspecs
#   --paginate(-p)         # Pipe all output to less (or $PAGER)
#   --super-prefix: string # Set a prefix which gives a path from above a repository down to its root
#   --version              # The git version
#   --work-tree: string    # Set the path to the working tree
#   -C: string             # Run as if the given path is CWD
#   -c: string             # Set a configuration parameter <name>=<value>
# ]

