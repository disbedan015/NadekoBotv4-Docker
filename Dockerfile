FROM python:3.13.0a2-alpine3.19

#prereqs
RUN apk add --no-cache --update bash curl yt-dlp dotnet6-sdk opus opus-tools libopus-dev libsodium-dev wget ffmpeg

#NadekoBotV4
COPY scripts/ /opt/scripts/
CMD ["mkdir", "nadeko"]
CMD ["chmod", "+x" "/opt/scripts/00_Installer.sh"]
CMD ["bash", "/opt/scripts/00_Installer.sh"]