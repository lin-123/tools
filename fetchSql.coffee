process.env.NODE_ENV ?= 'development' 
process.env.agent ?= 'yg'

_ = require 'lodash'
ORM = require "./model/ORM"

redisFactory = require './utils/redis_factory'
messageStore = require './lib/service/message_store_service'
# client = require('redis').createClient()
client = redisFactory.getPooledClient()

# config 
timestampKey = process.env.agent + '_fetch_mysql_timestamp'
timeDiff = 30*2 # 拉取message 的时间差， 以’天‘为单位

# delayTime 为fetch 操作延迟时间
# 若指定fetchTonight = true 时， 则在次日0：00执行fetch 操作
delayTime = 0
fetchTonight = false

getFetchDate = (cb)->
  client.get timestampKey, (err, result)->
    console.log err, result, 'client.get'
    if err 
      cb err, null
      return
    
    if result
      timestamp = parseInt(result)
      cb null, timestamp
      return

    mdate = new Date()
    timestamp = mdate.setDate(mdate.getDate() - timeDiff)
    cb null, timestamp

setFetchDate = (timestamp)->
  client.set timestampKey, timestamp

fetchSql = ->
  console.log 'start fetch...'
  ORM.initializeModel ()->
    getFetchDate (err, timestamp)->
      if err 
        console.log err
        return
      console.log 'getFetchDate return ', timestamp
      
      ORM.models.MessageModel.find()
      .where {createdAt: {'>' : timestamp}}
      .sort 'createdAt'
      .exec (err, messages)->
        # 拉取的消息结果， 按时间升序  
        console.log "get #{messages.length} messages from sql"
        if messages.length <= 0 
          return

        setFetchDate messages[messages.length-1].createdAt
        _.map messages, (message)->    
          messageStore.saveMessageToRedis JSON.stringify(message)

fetchSchedule = null
fetchDelay = (delayTime)->
  fetchSchedule = setTimeout ->
    fetchSql()
  ,delayTime

cancelFetch = ->
  unless fetchSchedule
    return
  clearTimeout fetchSchedule
  fetchSchedule = null

startTonight = ->
  now = new Date()

  year = now.getFullYear()
  month = now.getMonth()+1
  date = now.getDate()  
  tonight = new Date("#{year}-#{month}-#{date+1}")

  delayTime = tonight.getTime() - now.getTime()
  if delayTime < 0
    return console.log 'error'

  fetchDelay delayTime

if fetchTonight
  startTonight()
else
  fetchDelay delayTime
