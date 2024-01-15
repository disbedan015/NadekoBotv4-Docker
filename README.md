I couldn't find a NadekoBotv4 docker container so I made one
this is the first docker container I've ever made

Currently this is setup for 4.3.18 Nadekobot

presently failing to deploy resolving the errors one at a time


Build and deployment instructions

gh repo clone disbedan015/NadekoBot-Docker ~/NadekobotDocker
cd ~/NadekobotDocker
sudo docker build -t nadekov4 .
sudo docker run --name nadekobotv4 -e DISCORDTOKEN=$discordbottoken -e OWNERID=$discordownerid nadekov4
