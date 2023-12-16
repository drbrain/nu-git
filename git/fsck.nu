# Verify the connectivity and validity of objects in the database
export extern "git fsck" [
  ...object: string   # An object to treat as the head of an unreachability trace
  --unreachable       # Show objects that exist but are unreachable from the reference nodes
  --dangling          # Print objects that exist but are never directly used
  --no-dangling       # Omit dangling objects
  --root              # Report root nodes
  --tags              # Report tags
  --cached            # Consider any object recording in the index as a head node for an unreachability trace
  --no-reflogs        # Do not consider commits that are referenced only by a reflog entry to be reachable
  --full              # Check objects found in alternate object pools and packed git archives
  --connectivity-only # Check only the connectivity of reachable objects
  --strict            # Enable more strict checking
  --verbose           # Be verbose
  --lost-found        # Write dangling objects into the lost-found directory
  --name-objects      # Display how a named object is reachable
  --progress          # Report progress status
  --no-progress       # Do not report progress status
]

