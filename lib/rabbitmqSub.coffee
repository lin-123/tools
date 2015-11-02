amqp = require 'amqp'
config = require('../config/rabbitmq_conf')

# reconnect every 60s if failed
implementOption =
  defaultExchangeName: ''
  reconnect: true
  reconnectBackoffStrategy: 'linear'
  reconnectExponentialLimit: 120000
  reconnectBackoffTime: 60000

queueName = "offline.notify" # 可以是任何值
exchangeName = 'offline'
routingKey = "#"

client = amqp.createConnection config, implementOption
client.on "ready", ->
  client.queue queueName,{autoDelete:false}, (queue)->
    console.log "queue:#{queueName}"
    queue.bind exchangeName, routingKey
    
    queue.subscribe (message)->
      console.log 'rabbitmq recive message:', message.data.toString()

client.on "error", (err)->
  console.log "Error: connect to rabbitmq failed #{err}"

