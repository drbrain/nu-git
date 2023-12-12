# Completions for git options

export def cleanup [] {
  [
    { value: "strip", description: "Strip whitespace, commentary, collapse consecutive empty lines" },
    { value: "whitespace", description: "Strip whitespace, collapse consecutive empty lines" },
    { value: "verbatim", description: "Do not change the message" },
    { value: "scissors", description: "Same as 'whitespace' but remove lines following the scissors" },
    { value: "default", description: "'strip' if the message is to be edited, otherwise 'whitespace'" },
  ]
}

export def color [] {
  [
    { value: "always", description: "Always respect color in output" },
    { value: "never", description: "Never use color" },
    { value: "auto", description: "Use colors if the output is a terminal" }
  ]
}

# column display options from column.ui config option
export def column [] {
  [
    { value: "always", description: "Always show in columns" },
    { value: "auto", description: "Show in columns for terminal output" },
    { value: "never", description: "Never show in columns" },
    { value: "column", description: "Fill columns before rows" },
    { value: "dense", description: "Make unequal columns use more space" },
    { value: "nodense", description: "Make columns equal in size" },
    { value: "plain", description: "Show in one column" },
    { value: "row", description: "Fill rows before columns" },
  ]
}

export def mirror [] {
  [
    { value: "fetch", description: "Mirror every ref from the remote repository locally" },
    { value: "push", description: "Push local refs to the remote repository" },
  ]
}

# These aren't good descriptions
export def strategy [] {
  [
    { value: "ort", description: "Default strategy for two heads" },
    { value: "recursive", description: "Former default strategy for two heads" },
    { value: "resolve", description: "Tries to detect criss-cross merges, does not handle renames" },
    { value: "octopus", description: "Default strategy for multiple branches" },
    { value: "ours", description: "Resolve multiple heads, supersedes old development history" },
    { value: "subtree", description: "Modified ort strategy" },
  ]
}

