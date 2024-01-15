FROM ubuntu:jammy

#prereqs
RUN apt update && apt install  python3 python-is-python3 ffmpeg libopus0 opus-tools libopus-dev libsodium-dev youtube-dl -y
COPY . .
CMD ["bash", "01_Prereq.sh"]

#app download
CMD ["wget", "https://gitlab.com/api/v4/projects/9321079/packages/generic/NadekoBot-build/4.3.18/4.3.18-linux-x64-build.tar"]
CMD ["tar", "xf", "4.3.18-linux-x64-build.tar"]
CMD ["mv", "4.3.18-linux-x64-build.tar", "nadekobot"]

#systemd prep
CMD ["cp", "02_nadeko.service", "/etc/systemd/system/nadeko.service"]
CMD ["systemctl", "daemon-reload"]

#app Prep
CMD ["chmod", "+x", "nadekobot/NadekoBot"]
CMD ["cp", 03_NadekoRun.sh nadekobot/NadekoRun.sh]
CMD ["chmod", "+x", "nadekobot/NadekoRun.sh"]

#CREDS BUILD
CMD ["bash", "04_Creds.sh"]

#app Run
CMD ["systemctl", "start", "nadeko.service"]
CMD ["systemctl", "enable", "nadeko.service"]
