# room_redis.test.coffee

redis = require 'redis'
strings = require './config/strings'

room_redis = require './lib/room_redis'
# room_redis()
# # 网络断线会自动重连，

client = {}

restart = (client)->
  client.end()
  console.log '[[[[[[[[[[[[[['
  setTimeout ->
    client = room_redis
  ,2000

client = redis.createClient(strings.redis_conf.port,strings.redis_conf.host, strings.redis_conf.options)

client.on 'error', (err)->
  console.log err, 'error...'
  # client.connect() unless client.connected
  restart client

client.on 'connect', (err)->
  console.log arguments, 'connect...'

# client.on 'reconnecting', (options)->  
#   console.log arguments, 'reconnecting...'

#   if strings.redis_conf.options.max_attempts is options.attempt
#     client.attempts = 1
#     # restart client


client.on 'disconnect', ()->
  console.log arguments, 'disconnect....'

channel = strings.room_message_channels_prefix + '#hi'

room_redis ->
  i= 0
  setInterval ->
    client.publish channel, i++
  ,1000
