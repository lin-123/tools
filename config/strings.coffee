module.exports = 
  haveData: true

  room_messge_channels_prefix: 'room_messge_channel_'

  redis_conf:
    host: '192.168.19.175'
    # host: '192.168.33.10'
    port: '6379'
    options:
      max_attempts: 3
      retry_max_delay: 30
      retry_delay:30