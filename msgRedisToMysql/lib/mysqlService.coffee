thenjs =require 'thenjs'
logger = require '../utils/log'

pool = require './service/db_pool'

client = require('redis').createClient()

module.exports =
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
  #
  #全部存储成功 返回 null
  #存储失败 返回 失败时messageId
  insertDataByLoop: (messages, callback)->
    if messages.length <= 0
      return callback null
    pool.getConnection (err, conn)->
      if err
        logger.error "#{__filename}.insertDataByLoop pool.getConnection callback err", err
        return callback err

      length = 0
      thenjs.each messages, (cont, message)->
        message = JSON.parse(message)
        conn.query "insert into message values(#{message.id}, '#{message.content}', '#{message.time}')", (err, result)->
          length++ unless err
          cont err

          # if err
          #   errMsg =
          #     err:err
          #     messageId: message.id
          #     length: length
          #   return cont errMsg
          # length ++
          # cont null
      .fin (cont, err)->
        if err
          logger.error "#{__filename}.insertDataByLoop conn.query callback err", err
        errMsg =
          err: err
          length: length
        callback errMsg

        pool.releaseConnection conn
