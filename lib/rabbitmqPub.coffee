amqp = require("amqp")
config = require("../config/rabbitmq_conf")

exchangeName = 'offline'
routingKey = '#'
queueName = "offline.notify"

console.log config
connection = amqp.createConnection config
connection.on 'ready', (err)->
  console.log 'ready..', arguments
  
  exchange = connection.exchange(exchangeName, {type: 'direct',autoDelete:false})
  connection.queue queueName,{autoDelete:false}, (queue)->
    message = JSON.stringify
      type: 11
      datetime: new Date()
      createdAt: new Date()
      fromId: 'messageInfo.Uid'
      toId: 'messageInfo.Content.toId'
      content: 'messageInfo.Content.content'
      isRead: 'if messageInfo.Content.isRead then messageInfo.Content.isRead'
      readDateTime:' if messageInfo.Content.readDateTime then messageInfo.Content.readDateTime'
      clientId:' if messageInfo.Content.clientId then messageInfo.Content.clientId'

    queue.bind exchangeName,routingKey, ->
      i=0
      for j in [0..10000]
        exchange.publish routingKey, ">>>>send #{message} #{i++}"
        exchange.publish routingKey, ">>>>send #{message} #{i++}"
        exchange.publish routingKey, ">>>>send #{message} #{i++}"
        console.log " rabbitmq publish message: #{i}"
      
      # clock = setInterval ->
        
      #   clearInterval clock if i > 10000

        
      # ,1
