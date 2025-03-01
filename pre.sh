#!/bin/bash

#set -euf -o pipefail

cp -fR /etc/custom_files.base/. "${STEAMAPPDIR}/game/csgo/"

if [[ -d /etc/custom_files ]]; then
    cp -fR /etc/custom_files/. "${STEAMAPPDIR}/game/csgo/"
fi

# generate our SQL connection configuration
echo "TEZT: $CS2_ADMIN_SQL_HOST"
if [[ "$CS2_ADMIN_SQL_HOST" != "" ]]; then
    echo "Generating admin SQL configuration"
    CONFIG_PATH="${STEAMAPPDIR}/game/csgo/addons/counterstrikesharp/configs/plugins"

    mkdir -p "${CONFIG_PATH}/baseadminsql"
    cat > "${CONFIG_PATH}/baseadminsql/baseadminsql.json" << EOF
{
    "Database": {
        "Host": "$CS2_ADMIN_SQL_HOST",
        "Port": $CS2_ADMIN_SQL_PORT,
        "User": "$CS2_ADMIN_SQL_USER",
        "Password": "$CS2_ADMIN_SQL_PASSWORD",
        "Name": "$CS2_ADMIN_SQL_NAME"
    }
}
EOF

    mkdir -p "${CONFIG_PATH}/basecommtemp"
    cat > "${CONFIG_PATH}/basecommtemp/basecommtemp.json" << EOF
{
    "Database": {
        "Host": "$CS2_ADMIN_SQL_HOST",
        "Port": $CS2_ADMIN_SQL_PORT,
        "User": "$CS2_ADMIN_SQL_USER",
        "Password": "$CS2_ADMIN_SQL_PASSWORD",
        "Name": "$CS2_ADMIN_SQL_NAME"
    }
}
EOF

mkdir -p "${CONFIG_PATH}/basebans"
    cat > "${CONFIG_PATH}/basebans/basebans.json" << EOF
{
    "Database": {
        "Host": "$CS2_ADMIN_SQL_HOST",
        "Port": $CS2_ADMIN_SQL_PORT,
        "User": "$CS2_ADMIN_SQL_USER",
        "Password": "$CS2_ADMIN_SQL_PASSWORD",
        "Name": "$CS2_ADMIN_SQL_NAME"
    }
}
EOF

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