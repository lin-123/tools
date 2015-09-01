mysql = require 'mysql'

conn = mysql.createConnection
  host: 'localhost',
  user: 'root',
  password: 'root',
  database:'message',
  port: 3306
conn.connect()
module.exports = conn