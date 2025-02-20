#!/bin/bash

#set -euf -o pipefail

cp -fR /etc/custom_files.base/. "${STEAMAPPDIR}/game/csgo/"

if [[ -d /etc/custom_files ]]; then
    cp -fR /etc/custom_files/. "${STEAMAPPDIR}/game/csgo/"
fi

# Thanks to kus/cs2-modded-server

# Define the file name
FILE="${STEAMAPPDIR}/game/csgo/gameinfo.gi"

# Define the pattern to search for and the line to add
PATTERN="Game_LowViolence[[:space:]]*csgo_lv // Perfect World content override"
LINE_TO_ADD="\t\t\tGame\tcsgo/addons/metamod"

# Use a regular expression to ignore spaces when checking if the line exists
REGEX_TO_CHECK="^[[:space:]]*Game[[:space:]]*csgo/addons/metamod"

# Check if the line already exists in the file, ignoring spaces
if grep -qE "$REGEX_TO_CHECK" "$FILE"; then
    echo "$FILE already patched for Metamod."
else
    # If the line isn't there, use awk to add it after the pattern
    awk -v pattern="$PATTERN" -v lineToAdd="$LINE_TO_ADD" '{
        print $0;
        if ($0 ~ pattern) {
            print lineToAdd;
        }
    }' "$FILE" >tmp_file && mv tmp_file "$FILE"
    echo "$FILE successfully patched for Metamod."
fi