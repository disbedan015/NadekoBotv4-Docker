redis-server --daemonize yes && cd /nadeko/ && \
while true; do /usr/bin/dotnet /nadeko/NadekoBot.dll ; done