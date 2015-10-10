redis = require 'redis'
strings = require '../config/strings'

restart = (client)->
  client.end()
  console.log '[[[[[[[[[[[[[['
  setTimeout ->
    require('./room_redis')()  
  ,2000

#断线重连后 会有信息丢失 除非 拉取离线消息

# 本地没断线，需要与远程保持 心跳 对应
a = 
  timeout: 2000
  

module.exports = (callback)->
  console.log 'room room_redis o'
  client = redis.createClient(strings.redis_conf.port,strings.redis_conf.host, strings.redis_conf.options)
  roomMessageChannels = strings.room_message_channels_prefix+"#*"
  
  # console.log 'entry room redis ...', client

  # client.attempts = 21
  # console.log client.attempts, 'client'

  # client.retry_max_delay = 30
  # client.retry_delay = 30
  client.on "error", (err)->
    console.log err, 'error occur'
    # 重连
    # 
    restart client
    
  # client.on 'reconnecting', (options)->  
  #   console.log arguments, 'reconnecting...'

  #   if strings.redis_conf.options.max_attempts is options.attempt
  #     client.attempts = 4
      # restart client

  client.on 'pmessage', (sub, channel, actionStr)->
    console.log "recive message: #{actionStr}", client.attempts, client.max_attempts, client.retry_delay, client.retry_max_delay
    # if parseInt(actionStr)%3 is 0
    #   restart client
      
  client.on 'ready', (err)->
    if err
      log.error err
      #Send email
    console.log 'ready...'
    client.psubscribe(roomMessageChannels)
    callback?()

  client


  # enable_offline_queue: true,
  #   retry_max_delay: 30,
  #   retry_timer: null,
  #   retry_totaltime: 0,
  #   retry_delay: 150,
  #   retry_backoff: 1.7,
  #   attempts: 1,
  #   pub_sub_mode: false,
  #   subscription_set: {},
  #   monitoring: false,
  #   closing: false,
  #   server_info: {},
  #   auth_pass: null,
  #   parser_module: null,
  #   selected_db: null,
  #   old_state: null,
  #   domain: null,
  #   _events: {},
  #   _maxListeners: undefined,
  #   connectionOption: { port: '6379', host: '192.168.19.175', family: 4 },
  #   address: '192.168.19.175:6379' }