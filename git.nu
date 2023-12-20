# Expanded from
# https://github.com/nushell/nushell/blob/main/crates/nu-utils/src/sample_config/default_config.nu
# which is covered by the MIT license

export module add.nu
export module bisect.nu
export module blame.nu
export module branch.nu
export module checkout.nu
export module cherry-pick.nu
export module clean.nu
export module cleanup-repo.nu
export module clone.nu
export module commit.nu
export module config.nu
export module describe.nu
export module diff.nu
export module fetch.nu
export module fsck.nu
export module gc.nu
export module help.nu
export module hist.nu
export module init.nu
export module log.nu
export module ls-files.nu
export module merge.nu
export module mv.nu
export module prune.nu
export module pull.nu
export module push.nu
export module rebase.nu
export module remote.nu
export module restore.nu
export module rev-list.nu
export module rev-parse.nu
export module revert.nu
export module rm.nu
export module show.nu
export module show-branch.nu
export module stash.nu
export module status.nu
export module submodule.nu
export module switch.nu
export module symbolic-ref.nu
export module tag.nu

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

