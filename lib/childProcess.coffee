# childProcess.coffee
# node 多线程
# spwan exec execFile fork
# spwan 是最原始的创建多子进程的函数， 其他的都是封装的spwan

childProcess = require('child_process').fork('./child.js') # 相当于 .spawn(node, './child.js', options), options很多
# childProcess = require('child_process').spawn('coffee',[ './child.coffee'], {stdio:['ipc']})# .fork('./child.coffee') # 相当于 .spwan(coffee, './child.coffee')

# 接收子进程消息
childProcess.on 'message', ()->
  console.log arguments, 'parent process recive message'
  
  for i in [0...100] 
    console.log 'parent: ', i++
  
  # i=0

  # setInterval ->
  #   console.log 'parent: ', i++
  # ,1000



# 向子进程发送消息
childProcess.send 'parent: -----'
