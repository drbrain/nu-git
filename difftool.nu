use wrapper.nu [
  modified
]

# Show diff tools
export def --env tools [] {
  if ("GIT_NU_DIFF_TOOLS" in $env) {
    $env.GIT_NU_DIFF_TOOLS
  } else {
    let tools = run-external "git" "difftool" "--tool-help"
      | parse -r "\t\t(?<value>.+?)\\s+(?<description>.*)"
      | upsert value {|old|
        if ($old.value | str ends-with ".cmd") {
          $old.value
          | str replace ".cmd" ""
        } else {
          $old.value
        }
      }

    $env.GIT_NU_DIFF_TOOLS = $tools

    $tools
  }
}

# Show changes using common diff tools
export extern main [
  ...pathspec: path@modified # Files to diff
  --dir-diff(-d)             # Copy the modified files to a temporary location and performa directory diff on them
  --extcmd(-x): string       # Specify a custom command for viewing diffs
  --gui(-g)                  # Use diff.guitool instead of diff.tool
  --no-gui                   # Use diff.tool instead of diff.guitool
  --no-promet(-y)            # Do not prompt before launching a diff tool
  --no-symlinks              # Create copies instead of symlinks for --dir-diff
  --no-trust-exit-code       # Ignore the diff tool exit code
  --prompt                   # Prompt before each invaction of the diff tool
  --rotate-to: path@modified # Start showing the diff for the given path, paths before it will be shown at the end
  --skip-to: path@modified   # Start showing the diff for the given path, skipping paths before it
  --symlinks                 # Create symlinks instead of copies for --dir-diff
  --tool(-t): string@tools   # Use this diff tool
  --tool-help                # Print a list of diff tools that may be used with --tool
  --trust-exit-code          # Exit and forward the exit code when a diff tool exits non-zero
]
