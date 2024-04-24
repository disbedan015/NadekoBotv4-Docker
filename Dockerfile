FROM ubuntu:jammy

#prereqs
RUN apt update
RUN apt install curl apt-transport-https yt-dlp dotnet-sdk-6.0 -y libopus0 opus-tools libopus-dev libsodium-dev wget python3-all python-is-python3 libpython3.10 ffmpeg -y

#NadekoBotV4
COPY scripts/ /opt/scripts/
CMD ["bash", "/opt/scripts/00_Installer.sh"]