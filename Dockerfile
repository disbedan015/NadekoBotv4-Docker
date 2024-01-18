FROM ubuntu:jammy

#prereqs
RUN apt update && apt install curl apt-transport-https yt-dlp dotnet-sdk-6.0 -y libopus0 opus-tools libopus-dev libsodium-dev wget python3-all python-is-python3 libpython3.10 ffmpeg -y

#NadekoBotV4
COPY scripts/ /opt/scripts/
CMD ["mkdir", "nadeko"]
CMD ["rm", "/nadeko/creds.yml", "||", "true"]
CMD ["chmod", "+x" "/opt/scripts/00_Installer.sh"]
CMD ["bash", "/opt/scripts/00_Installer.sh"]