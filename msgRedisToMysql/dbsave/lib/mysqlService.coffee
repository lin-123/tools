conn = require './service/db_conn'

client = require('redis').createClient()

module.exports =
  saveToMysql: (key, callback)->
    client.lrange key, 0, -1, (err, messages)=>
      @insertData(messages, callback)

  insertData: (messages, callback, errs)->
    errs?= []
    # console.log messages, 'insertData'
    message = messages.pop()
    message = JSON.parse(message)

    conn.query "insert into message values(#{message.id}, '#{message.content}', '#{message.time}')", (err, rows, fields)=>
      #rows.affectedRows = 1
      if err then errs.push JSON.stringify(err)

      if messages.length > 0 then @insertData messages, callback,errs else callback errs 
    
  closeDB:()->
    conn.end()
