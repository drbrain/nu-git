# Expanded from
# https://github.com/nushell/nushell/blob/main/crates/nu-utils/src/sample_config/default_config.nu
# which is covered by the MIT license

export use add.nu
export use bisect.nu *
export use blame.nu
export use branch.nu
export use checkout.nu
export use cherry-pick.nu
export use clean.nu
export use cleanup-repo.nu
export use clone.nu
export use commit.nu
export use config.nu
export use describe.nu
export use diff.nu
export use difftool.nu
export use fetch.nu
export use fsck.nu
export use gc.nu
export use help.nu
export use hist.nu
export use init.nu
export use log.nu
export use ls-files.nu
export use merge.nu *
export use mv.nu
export use prune.nu
export use pull.nu
export use push.nu
export use rebase.nu *
export use remote.nu
export use reset.nu
export use restore.nu
export use rev-list.nu
export use rev-parse.nu
export use revert.nu *
export use rm.nu
export use show.nu
export use show-branch.nu
export use show-ref.nu
export use stash.nu
export use status.nu
export use submodule.nu
export use switch.nu
export use symbolic-ref.nu
export use tag.nu

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

