_ = require 'lodash'


redis = require 'redis'
client = redis.createClient('6379', '192.168.19.175')

messageRedis = JSON.stringify
  type: 33 #constants.messageTypes.fromCsr | constants.messageTypes.text
  datetime: new Date()
  content: "are you online"
  fromId: "1"
  toId: "101"
  isRead: false

messageCustomer = JSON.stringify
  type: 65  #constants.messageTypes.fromCsr | constants.messageTypes.image
  datetime: new Date(Date.now() - 1000)
  createdAt: Date.now() - 1000
  fromId: "hexi"
  toId: "101"
  isRead: false
  originImageUrl: 'image url'

messageCustomerInImage = JSON.stringify
  type: 33  # constants.messageTypes.fromCsr | constants.messageTypes.text
  datetime: new Date()
  content: "are you online"
  fromId: "hexi"
  toId: "101"
  isRead: false

# for i in [1..5]
#   setTimeout ->
#     messageRedis.createdAt = i #Date.now()
#     messageCustomer.createdAt = i #Date.now()
#     messageCustomerInImage.createdAt = i #Date.now()
#     client.lpush 'yg_message_list_1', messageRedis
#     client.lpush 'yg_message_list_1', messageCustomerInImage
#     client.lpush 'yg_message_list_1', messageCustomer
#   ,1000

params = 
  first: 0

first = 1439367144461
limit = 30
message = 
  type: 33
  datetime: new Date()
  createdAt: 3
  content: "are you online"
  fromId: "hexi"
  toId: "101"
  isRead: false
data = []
data.push JSON.stringify(message)
for i in [1,2]
  message.createdAt--
  data.push JSON.stringify(message)
console.log data, 'data'
messages = _.chain(data)
  .map (message)-> JSON.parse(message)

  .filter (message)-> message if message.createdAt <= params.first or params.first is 0  
  
  .take(limit)
  .value()
console.log messages


chatServiceCsr = ->
  client.lrange 'yg_message_list_1', 0, -1, (err, data)->
    console.log data,'data'
    params = 
      first: 1439366423379
    
    first = 1439367144461
    limit = 30
    
    type = 10
    types = [10, 4]

    messages = _.chain(data)
    .map (message)->
      return JSON.parse(message)
    .filter (message)->
      if not (message.type in types) and (message.createdAt >= first or first is 0)
        if message.type & 64
          content = message.content
          # message.thumbnailUrl = content.thumbnailUrl
          # message.thumbnailHeight = content.thumbnailHeight
          # message.thumbnailWidth = content.thumbnailWidth
          # message.originImageUrl = content.originImageUrl 
        return message 
    .sortByOrder("createdAt", "desc").take(limit).value()
    console.log messages

lodashDemo = ->
#lodash, 可读性前，面向数组
  messages = _.chain(data)
  .map (message)->
    return JSON.parse(message)
  .filter (message)->
    return message if message.toId <= 4  
  .sortByOrder("toId", "desc")
  .take(3)
  .value()
  console.log messages
