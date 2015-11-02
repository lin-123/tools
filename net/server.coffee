# server.coffee

net =  require 'net'

server = net.createServer (c)->
  c.on 'data', (data)->
    console.log data

    # console.log data.toString()

  c.on 'error', (err)->
    console.error err

server.listen 8888