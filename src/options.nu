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

export def conflict [] {
  [
    { value: "merge", description: "RCS style" },
    { value: "diff3", description: "RCS style with base hunk" },
    { value: "zdiff3", description: "diff3 omitting common lines in the conflict" },
  ]
}

export def mirror [] {
  [
    { value: "fetch", description: "Mirror every ref from the remote repository locally" },
    { value: "push", description: "Push local refs to the remote repository" },
  ]
}

export def sort_key [] {
  [
    { value: "refname", description: "Name of the ref" },
    { value: "objecttype", description: "Object type" },
    { value: "objectsize", description: "Object size" },
    { value: "objectname", description: "Object name (SHA-1)" },
    { value: "deltabase", description: "Object delta base, if stored as a delta" },
    { value: "upstream", description: "Upstream ref name" },
    { value: "push", description: "Ref push location" },
    { value: "HEAD", description: "The current ref" },
    { value: "symref", description: "The ref the symbolic ref refers to" },
    { value: "signature", description: "GPG signature" },
    { value: "signature:grade", description: "GPG signature grade" },
    { value: "signature:signer", description: "GPG signer" },
    { value: "signature:key", description: "GPG key" },
    { value: "signature:fingerprint", description: "GPG fingerprint" },
    { value: "signature:primarykeyfingerprint", description: "GPG primary key fingerprint" },
    { value: "signature:trustlevel", description: "GPG signature trust level" },
    { value: "worktreepath", description: "Absolute path to the worktree" },
    { value: "ahead-behind:", description: "Commits ahead and behind" },
    { value: "describe:", description: "Describe string" },
    { value: "tree", description: "" },
    { value: "parent", description: "Parent commit" },
    { value: "object", description: "" },
    { value: "type", description: "Object type" },
    { value: "tag", description: "" },
    { value: "creator", description: "" },
    { value: "creatordate", description: "" },

    { value: "author", description: "Author" },
    { value: "authorname", description: "Author name" },
    { value: "authoremail", description: "Author email" },
    { value: "authordate", description: "Author date" },
    { value: "committer", description: "Committer" },
    { value: "committername", description: "Committer name" },
    { value: "committeremail", description: "Committer email" },
    { value: "committerdate", description: "Committer date" },
    { value: "tagger", description: "Tagger" },
    { value: "taggername", description: "Tagger name" },
    { value: "taggeremail", description: "Tagger email" },
    { value: "taggerdate", description: "Tagger date" },

    { value: "raw", description: "Raw object data" },
    { value: "raw:size", description: "Raw object size" },

    { value: "contents", description: "Commit or tag message" },
    { value: "contents:size", description: "Message size" },
    { value: "contents:subject", description: "Message subject" },
    { value: "contents:body", description: "Message body" },
    { value: "contents:signature", description: "Tag signature" },
    { value: "contents:lines=", description: "First N message lines" },

    { value: "trailers", description: "" },

    { value: "version:refname", description: "Version" },
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

export def whitespace [] {
  [
    { value: "nowarn", description: "Do not warn on trailing whitespace" },
    { value: "warn", description: "Warn on whitespace errors" },
    { value: "fix", description: "Warn and fix trailing whitespace" },
    { value: "error", description: "Fail on some whitespace errors" },
    { value: "error-all", description: "Fail on all whitespace errors" },
  ]
}

