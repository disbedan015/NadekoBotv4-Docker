FROM mcr.microsoft.com/dotnet/aspnet:8.0

#prereqs
RUN apk add --no-cache bash software software-properties-common curl apt-transport-https yt-dlp libopus0 opus-tools libopus-dev libsodium-dev wget python3-all python-is-python3 libpython3-dev ffmpeg

#NadekoBotV4
COPY scripts/ /opt/scripts/
CMD ["bash", "/opt/scripts/00_Installer.sh"]