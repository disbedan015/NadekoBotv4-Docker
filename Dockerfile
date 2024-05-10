FROM ubuntu:noble

#prereqs
RUN apt update
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:dotnet/backports
RUN apt install curl apt-transport-https yt-dlp dotnet-sdk-6.0 -y libopus0 opus-tools libopus-dev libsodium-dev wget python3-all python-is-python3 libpython3-dev ffmpeg -y

#NadekoBotV4
COPY scripts/ /opt/scripts/
COPY data/ /nadeko/data
CMD ["bash", "/opt/scripts/00_Installer.sh"]