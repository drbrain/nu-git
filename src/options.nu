# Completions for git options

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

