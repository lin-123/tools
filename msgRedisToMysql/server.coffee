# redisService.coffee
child = require('child_process').fork('./msgRedisToMysql/utils/child.js')

redis = require 'redis'
client = redis.createClient()

# module.exports = ()->
message = 
  id: 0
  content: 'hahaha ...'
  time: new Date().getTime()

option = 
  cmd:'save'
  key: 'list1'
  start: 0
  stop: -1

module.exports = (key, callback)->
  option.args = key
  console.log '---server.coffee-----'
  child.send JSON.stringify option   

  child.on 'message', (err)->
    callback err, key
