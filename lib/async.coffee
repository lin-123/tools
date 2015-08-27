async = require "async"

# Async是一个流程控制工具包，提供了直接而强大的异步功能。
# 基于Javascript为Node.js设计，同时也可以直接在浏览器中使用。
# Async提供了大约20个函数，包括常用的 map, reduce, filter, forEach 等，
# 异步流程控制模式包括，串行(series)，并行(parallel)，瀑布(waterfall)等。


# async 主要实现了三个部分的流程控制功能
#   集合 collections
#   流程控制 controle flow 
#   工具类 utils

collections = ()->
# each map forEach 都不会改变初始值

  args = [1,2,3]

  # 1. each 对集合中的每个元素执行相同操作， 无返回值
  console.log "before async.each args=#{args}"
  async.each args, (arg)->
    setTimeout ()->
      console.log "========arg = #{arg}====="
      arg++
    ,100
  ,(err)->
    console.log "err ocurre: #{err}" unless err is null
  setTimeout ->
    console.log "after async.each args=#{args}"
  ,1000

  # 2. map 同each， 但会将返回值放入result
  console.log "before async.map args=#{args}"
  async.map args, (arg, cb)->
    setTimeout ()->
      cb null, ++arg
    ,100
  ,(err, result)->
    console.log "after async.map args=#{JSON.stringify(arguments)}"

  # 3. forEachOf
  obj = 
    dev: "/dev.json"
    test: "/test.json"
    prod: "/prod.json"
  console.log "before async.forEachof args=#{JSON.stringify(obj)}"  
  async.forEachOf obj, (value, key, cb)->
    args = arguments
    setTimeout ->
      console.log "==========key = #{value}========="
      value = 'value'
      # cb err if err 
    ,100
  , (err)->
    console.log err
  setTimeout ->
    console.log "after async.forEachof args=#{JSON.stringify(obj)}"  
  ,1000

controleFlow = ()->
  # series parallel waterfall auto queue
  console.log "series 多个函数依次执行， 彼此之间没有数据交换"
  async.series [
    (cb)->
      setTimeout ->
        console.log "series function 1"
      ,1000
    ,(cb)->
      setTimeout ->
        console.log "series function 2"
      ,1000
  ],(err)->
    console.log err

  setTimeout ->
    console.log "\n\nparallel 多个函数并行执行 "
    async.parallel [
      (cb)->
        setTimeout ->
          console.log "parallel function 1"
        ,1000
      ,(cb)->
        setTimeout ->
          console.log "parallel function 2"
        ,1000
    ],(err)->
      console.log err
  ,5000

  setTimeout ->
    console.log "\n\nwaterfall 多个函数依次执行， 后一个函数需要用到前一个函数的数据"
    async.waterfall [
      (cb)->
        setTimeout ->
          console.log "waterfall function 1"
          cb null, "fefe"
        ,1000
      ,(arg1, cb)->
        console.log arguments
        setTimeout ->
          console.log "waterfall function 2, arg1= #{arg1}"
        ,1000
    ],(err)->
      console.log err
  ,10000  
  
  setTimeout ->
    console.log "\n\nauto 根据需要混合使用， 有并行，有串行 "
    async.auto
      func1: (cb)->
        setTimeout ->
          console.log "auto function 1"
          cb null, 1
        ,1000
      ,func2: (cb, arg1)->
        setTimeout ->
          console.log "auto function 2"
        ,1000
      ,func3: ['func1', 'func2', ()->
        setTimeout ->
          console.log "auto function 3"
      ]
    ,(err)->
      console.log err
  ,15000

# collections()
controleFlow()