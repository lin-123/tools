# child.coffee
mysqlService = require '../lib/mysqlService'

# 收到消息， 通知手下savetomysql
process.on 'message',(message)->
  console.log "收到消息， 即刻处理。。。", message
  option = JSON.parse message
  switch option.cmd
    when 'save'
      mysqlService.saveToMysql option.args, (err)-> 
        # console.log err,'return value'
        process.send err
