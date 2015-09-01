# node 单线程， 异步调用
# 多个异步调用依次执行
# 验证这多个异步调用 是同时在其他 io 线程中处理，
# 还是等待前一个调用处理完成再处理下一个调用
# 
# 模拟多个子进程的异步调用
#

#打印结果：
# child process recive message: thread 1...
# child process recive message: thread 2
# ,,,,,,,1
# ,,,,,,,2
# 

# 
#结论：
# 多个异步调用独立执行，彼此之间互不干扰
#


# 同步 synchronization 
# 异步 asynchronization

async1 = (message ,callback)->
  child1 = require('child_process').fork('./child.js')
  child1.send message
  child1.on 'message', ->
    callback 'ok'

async1 'thread 1...', ->
  console.log ',,,,,,,1'
async1 'thread 2', ->
  console.log ',,,,,,,2'