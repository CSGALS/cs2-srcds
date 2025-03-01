
#!/bin/bash

#set -euf -o pipefail

mkdir -p "${STEAMAPPDIR}"

# take ownership of our mounted path if different
sudo chown -R "${USER}:${USER}" "${STEAMAPPDIR}"

if [[ -f /etc/pre.sh ]]; then
    cp /etc/pre.sh "${STEAMAPPDIR}/pre.sh"
fi

if [[ -f /etc/post.sh ]]; then
    cp /etc/post.sh "${STEAMAPPDIR}/post.sh"
fi

# fix unbound variables errors
set +u

ENTRY_PATH="$(dirname "$0")/entry.sh"
"$ENTRY_PATH" "$@"