sinon = require 'sinon'
should = require 'should'
tj = require 'thenjs'
server = require '../server'

describe 'server', ->
  # 
  # 存2万条数据
  # 13029ms 一次并发
  # 11277ms 双线并发
  # 10420ms 四线并发
  # 
  # 5千条数据
  # 3712ms 一次并发

  it 'saveData， 一次并发', (done)->
    console.log new Date()

    tj (cont)-> 
      server 'list3', cont

    .then (cont, result)-> 
      console.log result, new Date(), 'result'
      done()

    .fail (cont, err)-> 
      # console.log err, new Date(), 'err    '
      done()

  it 'saveData， 双线并发', (done)->
    console.log new Date()
    tj.parallel [(cont)-> 
      server 'list4', cont
    
    ,(cont)-> 
      server 'list4', cont
    ]
    .then (cont, result)-> 
      console.log result, new Date(), 'result'
      done()

    .fail (cont, err)-> 
      # console.log err, new Date(), 'err    '
      done()

  it 'saveData， 四线并发', (done)->
    console.log new Date()
    
    tj.parallel [(cont)-> 
      server 'list1', cont
    
    ,(cont)-> 
      server 'list1', cont
    
    ,(cont)-> 
      server 'list1', cont

    ,(cont)-> 
      server 'list1', cont
    ]
    .then (cont, result)-> 
      console.log result, new Date(), 'result'
      done()

    .fail (cont, err)-> 
      # console.log err, new Date(), 'err    '
      done()
