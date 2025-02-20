
#!/bin/bash

#set -euf -o pipefail

# take ownership of our mounted path if different
sudo chown -R "${USER}:${USER}" "${STEAMAPPDIR}"

if [[ -f "${STEAMAPPDIR}/pre.sh" ]]; then
    rm "${STEAMAPPDIR}/pre.sh"
fi
if [[ -f "${STEAMAPPDIR}/post.sh" ]]; then
    rm "${STEAMAPPDIR}/post.sh"
fi

# fix unbound variables errors
set +u

ENTRY_PATH="$(dirname "$0")/entry.sh"
"$ENTRY_PATH" "$@"