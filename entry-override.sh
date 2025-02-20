
#!/bin/bash

set -euf -o pipefail

if [[ -f "${STEAMAPPDIR}/pre.sh" ]]; then
    rm "${STEAMAPPDIR}/pre.sh"
fi
if [[ -f "${STEAMAPPDIR}/post.sh" ]]; then
    rm "${STEAMAPPDIR}/post.sh"
fi

ENTRY_PATH="$(dirname "$0")/entry.sh"
"$ENTRY_PATH" "$@"