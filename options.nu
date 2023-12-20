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

export def color_moved [] {
  [
    [value description];
    ["no" "Moved lines are not highlighted"]
    ["default" "Blocks of moved text are painted in stripes"]
    ["plain" "Lines are painted without permutation detection"]
    ["blocks" "Blocks of moved text are painted"]
    ["zebra" "Blocks of moved text are painted in stripes"]
    ["dimmed-zebra" "Blocks of moved text are painted in stripes with uninteresting blocks dimmed"]
  ]
}

export def color_moved_ws [] {
  [
    [value description];
    ["no" "Do not ignore whitespace during move detection"]
    ["ignore-space-at-eol" "Ignore EOL whitespace changes"]
    ["ignore-space-change" "Ignore changes in amount of whitespace"]
    ["ignore-all-change" "Ignore whitespace changes when comparing lines"]
    ["allow-indentation-change" "Ignore whitespace changes when comparing lines"]
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

export def date [] {
  [
    { value: "relative", description: "Relative to the current time" },
    { value: "local", description: "Weekday Month Day HH:MM:SS YYYY local TZ" },

    { value: "iso", description: "YYYY-MM-DD HH:MM:SS TZ" },
    { value: "iso-local", description: "YYYY-MM-DD HH:MM:SS local TZ" },
    { value: "iso8601", description: "YYYY-MM-DD HH:MM:SS TZ" },
    { value: "iso8601-local", description: "YYYY-MM-DD HH:MM:SS local TZ" },

    { value: "iso-strict", description: "YYYY-MM-DDTHH:MM:SS TZ" },
    { value: "iso8601-struct", description: "YYYY-MM-DDTHH:MM:SS TZ" },
    { value: "iso-strict", description: "YYYY-MM-DDTHH:MM:SS local TZ" },
    { value: "iso8601-struct", description: "YYYY-MM-DDTHH:MM:SS local TZ" },

    { value: "rfc", description: "Weekday, DD Month YYYY HH:MM:SS TZ" },
    { value: "rfc2822", description: "Weekday, DD Month YYYY HH:MM:SS TZ" },
    { value: "rfc-local", description: "Weekday, DD Month YYYY HH:MM:SS local TZ" },
    { value: "rfc2822-local", description: "Weekday, DD Month YYYY HH:MM:SS local TZ" },

    { value: "short", description: "YYY-MM-DD" },
    { value: "short-local", description: "YYY-MM-DD (in local TZ)" },

    { value: "raw", description: "Epoch seconds TZ" },
    { value: "raw-local", description: "Epoch seconds local TZ" },

    { value: "human", description: "Relative to the current time" },
    { value: "human-local", description: "Relative to the current time" },

    { value: "unix", description: "Epoch seconds" },
    { value: "unix-local", description: "Epoch seconds" },

    { value: "format:", description: "strftime format" },
    { value: "format-local:", description: "strftime format (in local TZ)" },

    { value: "default", description: "Weekday Month Day HH:MM:SS YYYY TZ" },
    { value: "default-local", description: "Weekday Month Day HH:MM:SS YYYY local TZ" },
  ]
}

export def diff_algorithm [] {
  [
    [value description];

    ["default"   "Basic greedy diff algorithm (myers)"]
    ["histogram" "Patience that supports low-occurence common elements"]
    ["minimal"   "Produce the smallest diff possible"]
    ["myers"     "Basic greedy diff algorithm"]
    ["patience"  "Best for generating patches"]
  ]
}

export def diff_submodule [] {
  [
    [value description];
    ["short" "Show start and end commits (default)"]
    ["log" "List commits in the range"]
    ["diff" "Inline diff of changes"]
  ]
}

export def diff_word [] {
  [
    [value description];
    ["color" "Highlight with color"]
    ["plain" "Highlight with [-removed-] and {+added+}"]
    ["porcelain" "Highlight with a format for script consumption"]
    ["none" "Do not highlight"]
  ]
}

export def exclude_hidden [] {
  [
    [value description];

    [fetch "Do not include refs that would be hidden by git-fetch"]
    [receive "Do not include refs that would be hidden by git-receive-pack"]
    [uploadpack "Do not include refs that would be hidden by git-upload-pack"]
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

export def track [] {
  [
    { value: "direct", description: "Use the start point branch as the upstream" },
    { value: "inherit", description: "Copy the start point upstream configuration" },
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

export def ws_error [] {
  [
    [value description];
    ["all" "Errors in all lines"]
    ["context" "Errors in diff context lines"]
    ["default" "Errors in new and old lines"]
    ["new" "Errors in new lines"]
    ["none" "No errors"]
    ["old" "Errors in old lines"]
  ]
}

