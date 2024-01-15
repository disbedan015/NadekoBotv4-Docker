echo '#!/bin/bash'
echo ""
echo "echo \"Running NadekoBot in the background with auto restart\"
youtube-dl -U

echo \"Starting NadekoBot...\"

while true; do
    if [[ -d $PWD/nadekobot/output ]]; then
        cd $PWD/nadekobot/output || {
            echo \"Failed to change working directory to $PWD/nadekobot/output\" >&2
            echo \"Ensure that the working directory inside of '/etc/systemd/system/nadeko.service' is correct\"
            echo \"Exiting...\"
            exit 1
        }
    else
        echo \"$PWD/nadekobot/output doesn't exist\"
        exit 1
    fi

    dotnet NadekoBot.dll || {
        echo \"An error occurred when trying to start NadekBot\"
        echo \"Exiting...\"
        exit 1
    }

    echo \"Waiting for 5 seconds...\"
    sleep 5
    youtube-dl -U
    echo \"Restarting NadekoBot...\"
done

echo \"Stopping NadekoBot...\""