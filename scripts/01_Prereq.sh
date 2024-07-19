# $LOCALREDIS && apk add --no-cache redis-server -y && redis-server --daemonize yes || echo "no redis"
apk --force --no-cache  add procps
apk --force add linux-headers
apk —-force add --update alpine-sdk

cd ~
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable

cd deps

make lua hiredis linenoise jemalloc

cd ..

make

cp src/redis-server /usr/local/bin/
cp src/redis-cli /usr/local/bin/