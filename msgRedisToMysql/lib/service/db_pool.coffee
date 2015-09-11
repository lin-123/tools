mysql = require 'mysql'
mysqlConfig = require '../../config/mysql_config'

env = process.env.NODE_ENV | "developments"

pool = mysql.createPool  #mysqlConfig[env]
  host: 'localhost',
  user: 'root',
  password: 'root',
  database:'message',
  port: 3306
  acquireTimeout: 1000
  connectionLimit: 50
  queueLimit: 10

module.exports = pool

# methods:
# getConnection 获取连接
# acquireConnection 保持连接？
# releaseConnection 释放连接， 使其放回缓冲池队列
# end 关闭此链接
# query 查询
# _purgeConnection 清理缓冲池， 关闭空闲连接
# _removeConnection 释放所有连接


