#!/bin/bash -e
# Install dotnet
apt update && apt install curl -y && curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && apt install apt-transport-https dotnet-sdk-6.0 -y libopus0 opus-tools libopus-dev libsodium-dev wget redis-server python3-all python-is-python3 libpython3.10 ffmpeg -y && chmod a+rx /usr/local/bin/youtube-dl