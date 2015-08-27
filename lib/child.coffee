# child.coffee

process.on 'message', ()->
  console.log arguments, 'child process recive message'
  
  for i in [0...100] 
    console.log 'child: ', i++
   
  # i=0
  # setInterval ->
  #   console.log 'child: ', i++
  # ,1000

process.send 'child: messages ...'

