# 连接redis
redisConn = ->
  host = 'localhost'
  port = 6379
  key = 'key'
  value = 'this is value'
  client = require('redis').createClient(port, host)
  client.set key, value, (err, data)-> console.log 'redis callback:', err, data

# 连接mysql
mysqlConn = ->
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
expressFunc = ->
  app = require('express')()
  console.log __dirname, 'asdf'

  # 定位路径
  # 获取目录路径用 __dirname
  # 获取文件路径用 __filename
  htmlFile = require('path').join __dirname, "../resource/fragment.html"
  app.get '/',(req, res)->
    res.sendFile htmlFile # 返回一个html网页
    # res.send 'kakaka'
  app.listen(3001)
expressFunc()