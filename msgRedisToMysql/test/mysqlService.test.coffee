# mysqlService.test.coffee
sinon = require 'sinon'
should = require 'should'
thenjs = require 'thenjs'

mysqlService = require '../lib/mysqlService'
client = require('redis').createClient()

describe 'mysqlService', ->
  describe 'insertData', ->
    messages = []
    start = null
    beforeEach (done)->
      client.lrange 'list1', 0, -1, (err, data)->
        messages = data
        console.log new Date(), messages.length
        done()
    
    afterEach ->
      console.log new Date()
      console.log '==================='

    it 'normal, while循环向db 插入', (done)->
      #4149ms
      mysqlService.insertDataByLoop messages, (err)->
        console.log "err should be null, err=", err
        done()

    it 'normal, 递归循环向db 插入', (done)->
      #3640ms nodejs 是单线程， 使用递归, 每个分支重点会创建一个 connection， 由connection向数据库写数据， 
      #由于是多条分支一起写数据，故相对较快。
      mysqlService.insertDataByRecursive messages,(err)->
        should.not.exist(err)
        # console.log "err should be null, err=", err
        done()

    xit '存 redis', (done)->
      #0.5s
      # clien.lpush 'list3', messages[0],
      messages
      thenjs.each messages, (cont, message)->
        client.lpush 'list2', message, cont
      .then (cont, results)-> 
        console.log results[0], '====redis=====1'
        done()
      .fail (cont, err)->
        console.log err
        done()

  describe 'mysqlTest', ->
    pool = require '../lib/service/db_pool'
    it '验证getConnection 需要多少时间', (done)->
      pool.getConnection (err, conn)->
        # 58ms
        done()