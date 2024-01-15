echo "version: 7
token: $DISCORDTOKEN
ownerIds:
  - $OWNERID
usePrivilegedIntents: true
totalShards: 1
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
botCache: Redis
redisOptions: localhost:6379,syncTimeout=30000,responseTimeout=30000,allowAdmin=true,password=
db:
  type: sqlite
  connectionString: Data Source=data/NadekoBot.db
coordinatorUrl: http://localhost:3442
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
" >> /nadekobot/creds.yml