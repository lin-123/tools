# room_redis.test.coffee

redis = require 'redis'
strings = require '../config/strings'

# room_redis = require '../lib/room_redis'

# xdescribe 'room_redis', ->
#   client = redis.createClient()

#   client.on 'error', (err)->
#     console.log err
#     channel = 'aaa' #strings.room_message_channels_prefix + '#hi'

#   room_redis ->
#     i= 0
#     setInterval ->
#       client.publish channel, i++
#     ,100

#   it 'redis-server offline', (done)->
#       # setTimeout ->
#       #   room_redis.quit()
#       # ,1000
#       setTimeout ->
#         done()
#       ,4000

