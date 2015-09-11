sinon = require 'sinon'
should = require 'should'
thenjs = require 'thenjs'    

describe '验证测试', ->
  describe 'io与异步调用', ->
    it '测试多线程 ', (done)->
      require('../server') 'list1', (err, result)->
        console.log "list1 callback"
        flag = true

      console.log 'while loop start...'
      i = 200000000
      while i > 0

        if i in [190000000, 180000000, 170000000, 160000000, 150000000, 140000000, 130000000, 120000000, 110000000,
          90000000, 80000000, 70000000, 60000000, 50000000, 40000000, 30000000, 20000000, 10000000]
          console.log '疯狂加载中。。。。'
        i--  

      setTimeout ->
        console.log 'while loop finish...'
        done()
      ,5000

    it 'fs 异步线程 ', (done)->
      client = require('redis').createClient()
      client.lrange 'list3', 0, -1, (err, messages)-> 
        # nodejs 异步返回 会在下一个 tick 执行
        # 故当前先执行 while 循环体
        console.log 'redis.creatClient.lrange return...'
        require('fs').writeFile './messages', messages, (err, res)->
          console.log res, err, 'fs return...'

      console.log 'while loop start...'
      
      i = 200000000
      while i > 0
        if i in [190000000, 180000000, 170000000, 160000000, 150000000, 140000000, 130000000, 120000000, 110000000,
          90000000, 80000000, 70000000, 60000000, 50000000, 40000000, 30000000, 20000000, 10000000]
          console.log '疯狂加载中。。。。'
        i--  

      setTimeout ->
        console.log 'while loop finish...'
        done()
      ,5000

  describe 'Recursive&asnchronous call', ->
    it '此段代码执行时间为1s',->
      console.log new Date()
      i = 1000000000
      while i > 0
        i--
      console.log new Date()
    it '递归 异步调用 与 node单线程', (done)->
      
      delayMethod = (num, cb)->
        i = 1000000000
        while i > 0
          i--
        cb null, num
        # 
        # num 
        # 5 
        # 2 3 —》 第一次递归
        # 2 1 2 -》第二次递归
        #
        # 执行时间 3s 
        # 
        # 每次执行到此函数时， CPU会忙于执行循环，线程也就阻塞在这个地方
        # 由于递归函数会调用 3 次 delayMethod 故执行时间为3s
        #

        # 
        #  setTimeout ->
        #   cb null,num
        # ,1000          
        #
        # 输入 recursive(5, cb)
        #
        # num 
        # 5 
        # 2 3 —》 第一次递归
        # 2 1 2 -》第二次递归
        #
        # cb 延迟一秒， 最后执行时间 1.1s 
        #
        # setTimeout 将代码交付下个时钟执行
        # 当前线程仍然继续执行。 故会多个delayMethod同时执行
        # 使最后执行时间为1.1s
        #
        #    
      recursive = (num, cb)->
        console.log '---entry method ----', num
        if num in [1, 2]
          return delayMethod num, cb

        thenjs.parallel [(cont)->
          recursive parseInt(num/2), cont
        ,(cont)->
          recursive parseInt(num/2)+1, cont
        ]        
        .then (cont, result)-> cb null, result[0] + result[1]

      recursive 5, (err, res)-> 
        console.log err, res, 'callback'
        done()

  describe 'thenjs', ->
    obj = {}
    it 'Normal, cont ', (done)->
      obj.asyncMethod = (message, callback)->
        setTimeout ->
          callback null, message
        ,100

      thenjs.parallel [(cont)->
        obj.asyncMethod 'first', cont # 相当于 cont err, result
      ,(cont)->
        obj.asyncMethod 'second', cont
      ]
      .then (cont, result)-> 
        console.log result, 'paraller result'
        done()
      .fail (cont, err)-> 
        console.log err, 'paraller callback err' 
        done()


    it 'Error, cont 的使用', (done)->
      obj.asyncMethod = (message, callback)->
        setTimeout ->
          callback "#{message} err occuer...", null
        ,100

      thenjs.parallel [(cont)->
        obj.asyncMethod 'first', cont # 相当于 cont err, result
      ,(cont)->
        obj.asyncMethod 'second', cont
      ]
      .then (cont, result)-> 
        console.log result, 'paraller result'
        done()
      .fail (cont, err)-> 
        console.log err, 'paraller callback err' 
        done()

    it '测试thenjs.fail 捕获错误消息后 thenjs 的each 调用是否持续进行', (done)->
      # 测试结果： 一旦发生错误，会直接跳到错误处理部分， 整个操作回滚
      arr = [1,2,3,4,5]

      thenjs.each arr, (cont, item)->
        if item in [3, 5]
          cont "err:#{item}", null
          return
        item += 10
        cont null, item
      # .then (cont, result)->
      #   console.log result, "Normal result"
      # .fail (cont, err)->
      #   console.log err, "err handler"
      .fin (cont, err, result)->
        console.log "finally result", err, result, arguments
        console.log "arr is: ", arr
        done()

  describe 'console.log', ->
    it ',,,', ->
      err = 
        a: 'sdfsfd'
        b: 'fef'
      console.log err
      console.log "fefaefffe#{JSON.stringify(err)}", err
  
  describe 'DBPool', ->
    mysql = require 'mysql'

    pool = mysql.createPool
      host: 'localhost',
      user: 'root',
      password: 'root',
      database:'message',
      port: 3306

    # pool = require '../lib/service/db_conn'
    it 'get pool.getConnection',(done)->
      # console.log pool,'pool'
      # console.log pool.acquireConnection, 'acquireConnection'
      pool.getConnection (err, conn)->
        throw err if err
        conn.query 'select id from message where time=1440661683406', (err, rows, fields)->
          console.log err, rows.length, fields,'query result'
          done()

  describe '__dirname', ->
    # 获取目录路径用 __dirname
    # 获取文件路径用 __filename
    it 'show __dirname and path log', ()->
      __dirname.should.eql '/vagrant/01myfolder/mochatest/msgRedisToMysql/test'

      logFile = __dirname.slice(0, __dirname.length-4) + 'errResult.log'

      logFile.should.eql '/vagrant/01myfolder/mochatest/msgRedisToMysql/errResult.log'

    it 'use nodejs path method', ->
      logDir = require('path').join __dirname, "../log"
      logDir.should.eql '/vagrant/01myfolder/mochatest/msgRedisToMysql/log'

  describe 'fs', ->
    it '#appendFile', (done)->
      fs = require 'fs'
      message = JSON.stringify
        err: 'internal error'
      fs.appendFile './log', message+"\n", 'utf8'

      fs.readFile './log', 'utf8',()->
        console.log arguments 
        done()