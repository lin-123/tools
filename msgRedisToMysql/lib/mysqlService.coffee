thenjs =require 'thenjs'
logger = require '../utils/log'

pool = require './service/db_pool'

client = require('redis').createClient()

module.exports =
  saveToMysql: (key, callback)->
    client.lrange key, 0, -1, (err, messages)=>
      @insertDataByLoop messages, callback

  # 递归调用
  insertDataByRecursive: (messages, callback)->
    if messages.length <= 1000
      setTimeout @insertDataByLoop(messages, callback), 0
      return 

    thenjs.parallel [(cont)=>
      messagesLeftChild = messages.splice(0, parseInt(messages.length/2))
      @insertDataByRecursive messagesLeftChild, cont

    ,(cont)=>
      messagesRightChild = messages
      @insertDataByRecursive messagesRightChild, cont
    
    ]
    .then (cont, results)-> 
      callback null
    
    .fail (cont, err)->
      console.log err
      logger.error "#{__filename}.insertDataByRecursive ", err
      callback err
  
  #循环调用
  insertDataByLoop: (messages, callback)->
    if messages.length <= 0
      return callback null
    pool.getConnection (err, conn)->
      if err 
        logger.error "#{__filename}.insertDataByLoop pool.getConnection callback err", err
        return callback err

      thenjs.each messages, (cont, message)->
        message = JSON.parse(message)
        conn.query "insert into message values(#{message.id}, '#{message.content}', '#{message.time}')", cont
          
      .then (cont, results)-> 
        callback null
        pool.releaseConnection conn

      .fail (cont, err)-> 
        logger.error "#{__filename}.insertDataByLoop conn.query callback err", err
        callback err
        pool.releaseConnection conn