mysql = require 'mysql'
sql_config = require '../../config/mysql_config'

env = process[NODE_ENV] | "development"

conn = mysql.createConnection sql_config[env]

conn.connect()
module.exports = conn