redis = require 'redis'
strings = require './config/strings'

restart = (client)->
  console.log '============restart============='
  client?.end()
  setTimeout ->
    console.log '---------call getClient------------'    
    getClient()
  ,1000

getClient = (callback)->
  console.log '---------in getClient------------'    
  client = redis.createClient(strings.redis_conf.port,strings.redis_conf.host, strings.redis_conf.options)
  roomMessageChannels =  'aaa'

  client.on "error", (err)->
    console.log 'error...', err
    restart client
    
  client.on 'pmessage', (sub, channel, actionStr)->
    console.log 'pmessage', actionStr
    
  client.on 'ready', (err)->
    if err
      console.log 'error', err
    console.log 'ready...'
    callback?()

  client

module.exports = getClient