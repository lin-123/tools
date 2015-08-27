async = require "async"

describe "async 异步流程控制", ()->
  # Async是一个流程控制工具包，提供了直接而强大的异步功能。
  # 基于Javascript为Node.js设计，同时也可以直接在浏览器中使用。
  # Async提供了大约20个函数，包括常用的 map, reduce, filter, forEach 等，
  # 异步流程控制模式包括，串行(series)，并行(parallel)，瀑布(waterfall)等。
  
  before ()->
    console.log "====start===="

  # async 主要实现了三个部分的流程控制功能
  #   集合 collections
  #   流程控制 controle flow 
  #   工具类 utils
  
  describe " collections ", ()->
    it "#each it should log 1,2,3", ()->
      args = [1,2,3]
      console.log "before async.each args=#{args}"
      async.each args, (arg, cb)->
        arg++
      ,(err)->
        console.log "err ocurre: #{err}" unless err is null
      setTimeout ()->
        console.log "after async.each args=#{args}"
      ,100
    it '#map it should return some value', ()->
      args = [1,2,3]
      console.log "before async.map args=#{args}"
      async.map args, (arg, cb)->
        setTimeout ()->
          cb arg++
        ,100
      setTimeout ->
        console.log "after async.map args=#{args}"
      ,1000