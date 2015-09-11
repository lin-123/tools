# mysql_config.coffee
module.exports = 
  developments:
    host: 'localhost',
    user: 'root',
    password: 'root',
    database:'message',
    port: 3306
    acquireTimeout: 1000
    connectionLimit: 50
    queueLimit: 10
