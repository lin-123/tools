# client.coffee

net = require 'net'

client = net.createConnection 8888, 'localhost'

client.on 'error', (err)->
  console.error err

client.on 'data', (data)->
  console.log data

i=0

flush = (msg)->
  client.write msg, ->

setInterval ->
  for i in [0...10000]
    client.write "#{i}"
,1