FROM ubuntu:noble

#prereqs
RUN apt update
RUN apt install software-properties-common curl redis-server apt-transport-https yt-dlp dotnet-sdk-8.0 libopus0 opus-tools libopus-dev libsodium-dev wget python3-all python-is-python3 libpython3-dev ffmpeg -y

#NadekoBotV4
COPY scripts/ /opt/scripts/
CMD ["bash", "/opt/scripts/00_Installer.sh"]