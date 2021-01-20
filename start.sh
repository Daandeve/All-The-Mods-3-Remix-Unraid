#!/usr/bin/env bash

settings_files=("banned-ips.json" "banned-players.json" "ops.json" "whitelist.json")

for FILE in "${settings_files[@]}"
do
        if [ ! -f "$FILE" ]; then
                echo "File $FILE not found. Creating empty..."
                echo "[]" >> "/minecraft/settings/$FILE"
        fi
        echo "Linking /minecraft/settings/$FILE to /minecraft/$FILE"
        ln -s /minecraft/settings/$FILE /minecraft/$FILE
done

touch /minecraft/settings/server.properties
ln -s /minecraft/settings/server.properties /minecraft/server.properties

/minecraft/ServerStart.sh
