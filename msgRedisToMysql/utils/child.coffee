# child.coffee
logger = require '../utils/log'
mysqlService = require '../lib/mysqlService'
process.env.NODE_ENV ?= "development"

errHandler = (path, err)->
  logger.error path, err

saveToMysql = (key, start, stop, callback)->
  # get redis keys 
  client.lrange key, start, stop, (err, messages)=>
    errHandler("#{__dirname}.saveToMysql client.lrange callback err, key:#{key}, start:#{start}, stop:#{stop}", err) if err
      
    mysqlService.insertDataByLoop messages.reverse(), (errMsg)->
      client.ltrim key, 0, messages.length - errMsg.length, (err)->
        # 如果ltrim 出错怎么处理
        errHandler("#{__dirname}.saveToMysql client.ltrim callback err, key:#{key}, start:#{start}, stop:#{stop}", err) if err  

# 收到消息， 通知手下savetomysql
# 
# 根据option 做相应操作
# option = 
#   cmd: 'save'
#   key: 'list1'
#   start: 0
#   stop: -1

process.on 'message',(message)->
  console.log "收到消息， 即刻处理。。。", message
  option = JSON.parse message

  switch option.cmd
    when 'save'
      saveToMysql option.key, start, stop, (err)->
