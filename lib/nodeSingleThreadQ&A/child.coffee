# child.coffee

process.on 'message', (message)->
  console.log "child process recive message: #{message}"
  setTimeout ->
    process.send 'child: messages ...'
  ,1000


