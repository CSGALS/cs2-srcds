
#!/bin/bash

#set -euf -o pipefail

if [[ -f "${STEAMAPPDIR}/pre.sh" ]]; then
    rm "${STEAMAPPDIR}/pre.sh"
fi
if [[ -f "${STEAMAPPDIR}/post.sh" ]]; then
    rm "${STEAMAPPDIR}/post.sh"
fi

chown -R ${user}:${user} "${STEAMAPPDIR}"
chown -R ${user}:${user} "${STEAMAPPDIR}"

# fix unbound variables errors
set +u

ENTRY_PATH="$(dirname "$0")/entry.sh"
"$ENTRY_PATH" "$@"