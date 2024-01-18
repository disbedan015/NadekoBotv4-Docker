FROM python:3.13.0a2-alpine3.19

#prereqs
RUN apk add --no-cache --update bash curl yt-dlp dotnet6-sdk opus opus-tools opus-dev libsodium-dev wget ffmpeg gcompat

#NadekoBotV4
COPY scripts/ /opt/scripts/
COPY nadeko/ /nadeko
CMD ["chmod", "+x" "/opt/scripts/00_Installer.sh"]
CMD ["bin/bash", "/opt/scripts/00_Installer.sh"]