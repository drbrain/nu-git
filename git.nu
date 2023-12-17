# Expanded from
# https://github.com/nushell/nushell/blob/main/crates/nu-utils/src/sample_config/default_config.nu
# which is covered by the MIT license

export module add.nu
export module blame.nu
export module branch.nu
export module checkout.nu
export module cherry-pick.nu
export module cleanup-repo.nu
export module clone.nu
export module commit.nu
export module config.nu
export module diff.nu
# export use git/fetch.nu *
# export use git/fsck.nu *
# export use git/gc.nu *
# export use git/hist.nu *
# export use git/init.nu *
# export use git/log.nu *
# export use git/ls-files.nu *
# export use git/merge.nu *
# export use git/mv.nu *
# export use git/prune.nu *
# export use git/pull.nu *
# export use git/push.nu *
# export use git/rebase.nu *
# export use git/remote.nu *
# export use git/restore.nu *
# export use git/rev-parse.nu *
# export use git/revert.nu *
# export use git/rm.nu *
# export use git/show.nu *
# export use git/stash.nu *
export module status.nu
# export use git/submodule.nu *
# export use git/switch.nu *
# export use git/symbolic-ref.nu *
# export use git/tag.nu *

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

