# redisService.coffee
child = require('child_process').fork('./dbsave/server.js')

redis = require 'redis'
client = redis.createClient()

# module.exports = ()->
message = 
  id: 0
  content: 'hahaha ...'
  time: new Date().getTime()

saveMessage = setInterval ->
  #store message
  # console.log "save #{message.id}th message in redis ..."
  client.lpush 'list1', JSON.stringify(message)
  message.id++
  message.time = new Date().getTime()
,1000

setTimeout ->
  clearInterval(saveMessage)

  option = JSON.stringify
    cmd:'save'
    args: 'list1'

  # child.send option
,1000

child.on 'message', (err)->
  console.log '干的好。。。' unless err
