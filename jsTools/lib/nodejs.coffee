module.exports = $ =
  # nodejs 异步控制工具， thenjs, async
  thenjsOpt: ->
    Thenjs = require 'thenjs'
    task = (arg, callback)->
      # 模拟异步任务
      Thenjs.nextTick () ->
        callback(null, arg)

    Thenjs (cont)->
      task(10, cont)
    .then (cont, arg) ->
      console.log(arg)
      cont(new Error('error!'), 123)
    .fin (cont, error, result) ->
      console.log(error, result)
      cont()
    .each [0, 1, 2], (cont, value) ->
      task(value * 2, cont)
      # 并行执行队列任务，把队列 list 中的每一个值输入到 task 中运行
    .then (cont, result) ->
      console.log(result)
      cont()
    .parallel [
      (cont)->
        setTimeout ()->
          console.log('parallel task 1')
          cont(null, 'task1')
        , 1000
      ,
      (cont)->
        setTimeout ()->
          console.log('parallel task 2')
          cont(null, 'task2')
        1050
      ]
    .then (cont, result)->
      console.log(result)
      cont('error')
    .series([
      # 串行执行队列任务
      (cont)-> task(88, cont)
      # 队列第一个是异步任务
      ,
      (cont)-> cont(null, 99)
      # 第二个是同步任务
    ])
    .then  (cont, result) ->
      console.log(result)
      cont(new Error('error!!'))
    .fail (cont, error) ->
      console.log(error)
      console.log('DEMO END!')

    race = ()->
      Thenjs.parallel([
        (cont)->
          setTimeout(()->
            console.log('parallel task 1')
            cont(null, 'task1')
          , 1000)
        ,
        (cont)->
          setTimeout(()->
            console.log('parallel task 2')
            cont(null, 'task2')
          , 1050)
      ])
      .then (cont, res)->
        console.log(arguments, 'then')
      .fin ()->
        console.log(arguments, 'finally')
      .fail (cont, res)->
        console.log(arguments, 'fail')

  AsyncOpt: ->
    # Async是一个流程控制工具包，提供了直接而强大的异步功能。
    # 基于Javascript为Node.js设计，同时也可以直接在浏览器中使用。
    # Async提供了大约20个函数，包括常用的 map, reduce, filter, forEach 等，
    # 异步流程控制模式包括，串行(series)，并行(parallel)，瀑布(waterfall)等。


    # async 主要实现了三个部分的流程控制功能
    #   集合 collections
    #   流程控制 controle flow
    #   工具类 utils
    async = require "async"

    # each map forEach 都不会改变初始值

    args = [1,2,3]

    # 1. each 对集合中的每个元素执行相同操作， 无返回值
    console.log "before async.each args=#{args}"
    async.each args, (arg)->
      setTimeout ()->
        console.log "========arg = #{arg}====="
        arg++
      ,100
    ,(err)->
      console.log "err ocurre: #{err}" unless err is null
    setTimeout ->
      console.log "after async.each args=#{args}"
    ,1000

    # 2. map 同each， 但会将返回值放入result
    console.log "before async.map args=#{args}"
    async.map args, (arg, cb)->
      setTimeout ()->
        cb null, ++arg
      ,100
    ,(err, result)->
      console.log "after async.map args=#{JSON.stringify(arguments)}"

    # 3. forEachOf
    obj =
      dev: "/dev.json"
      test: "/test.json"
      prod: "/prod.json"
    console.log "before async.forEachof args=#{JSON.stringify(obj)}"
    async.forEachOf obj, (value, key, cb)->
      args = arguments
      setTimeout ->
        console.log "==========key = #{value}========="
        value = 'value'
        # cb err if err
      ,100
    , (err)->
      console.log err
    setTimeout ->
      console.log "after async.forEachof args=#{JSON.stringify(obj)}"
    ,1000

  controleFlow: ->
    # series parallel waterfall auto queue
    console.log "series 多个函数依次执行， 彼此之间没有数据交换"
    async.series [
      (cb)->
        setTimeout ->
          console.log "series function 1"
        ,1000
      ,(cb)->
        setTimeout ->
          console.log "series function 2"
        ,1000
    ],(err)->
      console.log err

    setTimeout ->
      console.log "\n\nparallel 多个函数并行执行 "
      async.parallel [
        (cb)->
          setTimeout ->
            console.log "parallel function 1"
          ,1000
        ,(cb)->
          setTimeout ->
            console.log "parallel function 2"
          ,1000
      ],(err)->
        console.log err
    ,5000

    setTimeout ->
      console.log "\n\nwaterfall 多个函数依次执行， 后一个函数需要用到前一个函数的数据"
      async.waterfall [
        (cb)->
          setTimeout ->
            console.log "waterfall function 1"
            cb null, "fefe"
          ,1000
        ,(arg1, cb)->
          console.log arguments
          setTimeout ->
            console.log "waterfall function 2, arg1= #{arg1}"
          ,1000
      ],(err)->
        console.log err
    ,10000

    setTimeout ->
      console.log "\n\nauto 根据需要混合使用， 有并行，有串行 "
      async.auto
        func1: (cb)->
          setTimeout ->
            console.log "auto function 1"
            cb null, 1
          ,1000
        ,func2: (cb, arg1)->
          setTimeout ->
            console.log "auto function 2"
          ,1000
        ,func3: ['func1', 'func2', ()->
          setTimeout ->
            console.log "auto function 3"
        ]
      ,(err)->
        console.log err
    ,15000


  # 连接redis
  redisConn: ->
    host = 'localhost'
    port = 6379
    key = 'key'
    value = 'this is value'
    client = require('redis').createClient(port, host)
    client.set key, value, (err, data)-> console.log 'redis callback:', err, data

  # 连接mysql
  mysqlConn: ->
    mysql = require 'mysql'
    dbConfig =
      host: 'localhost'
      user: 'root'
      password: 'root'
      database:'test'
      port: 3306
      acquireTimeout: 1000
      connectionLimit: 50
      queueLimit: 10
    # 数据库连接池
    pool = mysql.createPool dbConfig
    pool.getConnection (err, conn)->
      if err then return console.error 'DB getConnection Error: ', err
      console.log 'DB pool connect success.'
      conn.query 'select * from message', (err, data)->
        console.log 'db pool query Data: ', err, data

    # 直接连
    connection = mysql.createConnection
      host     : 'localhost',
      user     : 'root',
      password : 'root',
      database : 'test'
    connection.connect (err)->
      if err then return console.error 'db connect error: ', err
      console.log 'db connection success, '
      connection.query 'select * from message', (err, data)->
        console.log 'query result: ', err, data
        connection.end()

  # express 搭建简单服务器
  expressFunc: ->
    app = require('express')()
    console.log __dirname, 'asdf'

    # 定位路径
    # 获取目录路径用 __dirname
    # 获取文件路径用 __filename
    htmlFile = require('path').join __dirname, "../resource/fragment.html"
    app.get '/',(req, res)->
      console.log req
      res.sendFile htmlFile # 返回一个html网页

      # res.send 'kakaka'
    app.listen(3001)

  # 静态服务器
  staticServer: ->
    port=process.env.PORT || 9123
    require('http').createServer( (req, res)->
      console.log('request: ', req.url)
      url = req.url
      if(url == '/') then url = '/index.html'
      file_path = require('path').join(__dirname+url)
      console.log url.search('.json')
      ContentType = if url.search('.json')>0 then 'text/json; charset=utf-8' else 'text/html; charset=utf-8'

      require('fs').readFile file_path, (err, chunk)->
        res.writeHead(200, {'Content-Type': ContentType})
        msg = if err then JSON.stringify('没找到对应文件， 请确认文件名是否正确') else chunk

        res.write(msg,'utf8')
        res.end()

    ).listen(port)

# process.env.agent
funcName = process.env.runFunc
console.log "run #{funcName}"
unless $[funcName]() then console.log 'wrong input runFunc'