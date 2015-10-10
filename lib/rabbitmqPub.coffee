amqp = require("amqp")
config = require("../config/rabbitmq_conf")

exchangeName = 'offline'
routingKey = '#'
queueName = "offline.notify"

connection = amqp.createConnection config
connection.on 'ready', ->
  exchange = connection.exchange(exchangeName, {type: 'direct',autoDelete:false})
  connection.queue queueName,{autoDelete:false}, (queue)->

    queue.bind exchangeName,routingKey, ->
      i=0
      setInterval ->
        exchange.publish routingKey, i++
        console.log " rabbitmq publish message: #{i}"
      ,100
