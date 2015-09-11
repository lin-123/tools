sinon = require 'sinon'
should = require 'should'

describe 'node', ->
  describe 'for', ->
    it 'test loop for ', ->
      obj = 
        index: 1
        msg: 'obj...'

      objs = []
      for i in [0..3] 
        obj.index = i
        objs.push JSON.stringify(obj)

      for msg, index in objs
        # msg.index.should.eql 3-index
        console.log msg, index, typeof msg
        # msg.msg.should.eql 'obj...'
        
  describe '#modified strings value, then get this value again', ->
    # node 模块在第一次引用后会放入缓存， 之后再次引用此模块的数据时直接从缓存取此数据 而不会再次引用此模块
    it '#set value', ()->
      strings = require '../config/strings'
      strings.haveData.should.eql true
      strings.haveData = false

    it '#get value ', ->
      strings = require '../config/strings'
      strings.haveData.should.eql false