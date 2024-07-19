FROM alpine:edge

#prereqs
RUN apk add --no-cache gcompat redis dotnet8-sdk bash curl yt-dlp opus opus-tools opus-dev libsodium-dev wget python3 python3-dev ffmpeg

#NadekoBotV4
COPY scripts/ /opt/scripts/
CMD ["bash", "/opt/scripts/00_Installer.sh"]