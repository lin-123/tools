# # romm_redis.coffee

# process.env.NODE_ENV ?= "development"
# process.env.agent ?= "yg"

# log = require("../utils/log_utils")
# redis_factory = require("../utils/redis_factory")
# resource = require("../config/resource")

# hub = require("../lib/hub")

redis = require 'redis'
strings = require './config/strings'

console.log '---------room redis------------'

restart = (client)->
  console.log '============restart============='
  client?.end()
  setTimeout ->
    console.log '---------call getClient------------'    
    getClient()
  ,1000 #resource.redis_options.restart_delay

getClient = (callback)->
  console.log '---------in getClient------------'    
  client = redis.createClient(strings.redis_conf.port,strings.redis_conf.host, strings.redis_conf.options)
  roomMessageChannels =  'aaa' #resource.redis_keys.room_message_channel_prefix+"#*"

  client.on "error", (err)->
    #Send email
    # log.error err
    console.log 'error...', err
    restart client
    
  client.on 'pmessage', (sub, channel, actionStr)->
    console.log 'pmessage', actionStr
    # action = JSON.parse(actionStr)
    # hub[action.type](action.nsp, action.uid, action.room)

  client.on 'ready', (err)->
    if err
      console.log 'error', err
      #log.error err
      #Send email
    console.log 'ready...'
    # client.psubscribe(roomMessageChannels)
    callback?()

  client

getClient()

# module.exports = getClient