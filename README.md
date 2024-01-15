I couldn't find a NadekoBotv4 docker container so I made one
this is the first docker container I've ever made

Currently this is setup for 4.3.18 Nadekobot

[![Docker Image CI](https://github.com/disbedan015/NadekoBotv4-Docker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/disbedan015/NadekoBotv4-Docker/actions/workflows/docker-image.yml)

https://hub.docker.com/repository/docker/disbedan015/nadekobotv4/general

Build and deployment instructions

git pull https://github.com/disbedan015/NadekoBot-Docker ~/NadekobotDocker<br>
cd ~/NadekobotDocker<br>
sudo docker build -t nadekov4 .<br>
sudo docker run --name nadekobotv4 -e DISCORDTOKEN=$discordbottoken -e OWNERID=$discordownerid nadekov4
