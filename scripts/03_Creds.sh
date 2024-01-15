rm /nadeko/creds.yml
echo "version: 7
token: $DISCORDTOKEN
ownerIds:
  - $OWNERID
usePrivilegedIntents: true
totalShards: $SHARDS
googleApiKey: $GOOGLEAPI
google:
  searchId: 
  imageSearchId: 
votes:
  topggServiceUrl: $TOPGGURL
  topggKey: $TOPGGKEY
  discordsServiceUrl: $DISCORDURL
  discordsKey: $DISCORDVOTEKEY
patreon:
  clientId: $PATREONCLIENTID
  accessToken: $PATREONACCESSTOKEN
  refreshToken: $PATREONREFRESHTOKEN
  clientSecret: $PATREONCLIENTSECRET
  campaignId: $PATREONCAMPAIGNID
botListToken: $DISCORDBOTLIST
cleverbotApiKey: $CLEVERBOTAPI
gpt3ApiKey: $GPT3KEY
botCache: $CACHE
redisOptions: $REDISOPT
db:
  type: sqlite
  connectionString: Data Source=/db/NadekoBot.db
coordinatorUrl: $SHARDCORDURL
rapidApiKey: $RAPIDAPIKEY
locationIqApiKey: $LOCATIONIQKEY
timezoneDbApiKey: $TIMEZONEKEY
coinmarketcapApiKey: $COINMARKETKEY
osuApiKey: $OSUKEY
trovoClientId: $TROVOCLIENTID
twitchClientId: $TWITCHCLIENTID
twitchClientSecret: $TWITCHSECRET
restartCommand:
  cmd: 
  args: 
" >> /nadeko/creds.yml