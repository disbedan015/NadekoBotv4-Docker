No longer supported version 6 has it's own offical docker container.

I couldn't find a NadekoBotv4 docker container so I made one
this is the first docker container I've ever made

Currently this is setup for 5.3.9 Nadekobot

https://hub.docker.com/repository/docker/disbedan015/nadekobotv4/general

Build and deployment instructions

git pull https://github.com/disbedan015/NadekoBot-Docker ~/NadekobotDocker<br>
cd ~/NadekobotDocker<br>
sudo docker build -t nadekov4 .<br>
sudo docker run -d \
--name nadekobotv4 \
-e CACHE=Redis \
-e LOCALREDIS=true
-e REDISOPT=localhost:6379,syncTimeout=30000,responseTimeout=30000,allowAdmin=true,password= \
-e SHARDS=1 \
-e SHARDCORDURL=http://localhost:3442 \
-e DISCORDTOKEN= \
-e OWNERID= \
-e GOOGLEAPI= \
-e TOPGGURL= \
-e TOPGGKEY= \
-e DISCORDURL= \
-e DISCORDVOTEKEY= \
-e PATREONCLIENTID= \
-e PATREONREFRESHTOKEN= \
-e PATREONCLIENTSECRET= \
-e PATREONCAMPAIGNID= \
-e DISCORDBOTLIST= \
-e CLEVERBOTAPI= \
-e GPT3KEY= \
-e RAPIDAPIKEY= \
-e LOCATIONIQKEY= \
-e TIMEZONEKEY= \
-e COINMARKETKEY= \
-e OSUKEY= \
-e TROVOCLIENTID= \
-e TWITCHCLIENTID= \
-e TWITCHSECRET= \
-e DBTYPE=sqlite \
-e DBLOCATION=Data\ Source=data/NadekoBot.db \
-v home/nobody/nadeko/:/db/ \
 disbedan015/nadekobotv4
