should = require 'should'
sinon = require 'sinon'
demo = require '../lib/demo'

client = require('redis').createClient()

describe 'demo', ->
  describe '#sinon', ->
    describe '#spy', ->
      it 'demo1', (done)->
        spy = sinon.spy demo, 'sayHi' #监控 demo.sayHi() 不对其做具体操作
        demo.sayGoodBye = sinon.spy (fromOne, toOne)-> #模拟demo.sayGoodBye() 等同于stub， 可以用stub来做
          console.log '---------'
        
        demo.sayHi(1,2)
        demo.sayHi.withArgs(1,2).calledOnce.should.be.ok()
        demo.sayGoodBye.withArgs(2,1).calledOnce.should.be.ok()

        done()
        
      it "spy function", (done)->
          callback = sinon.spy()

          client.set 'testKey','value', callback
          client.get 'testKey', callback
          client.del 'testKey', callback

          setTimeout ->
            callback.callCount.should.eql 3

            done()
          ,200

    describe '#stub', ->
      it 'demo', ->
        obj = {}
        obj.func1 = sinon.spy (key, cb)->
          cb 'ok'

        obj.func1 'a', (msg)->
          msg.should.eql 'ok'

      it 'mock function', ->
        # sinon.stub client, 'set', (key, val, callback)->
        #   key.should.eql "testKey"
        #   val.should.eql 'value'
        #   callback null, 'ok'

        callback = sinon.spy()

        args = 
          key: 'testKey'
          value: 'value'

        stub = sinon.stub client, 'set'

        stub.withArgs(args).returns('eee')

        client.set 'testKey', 'value', ->
          console.log arguments, 'stub client.set...'

        client.set.callCount.should.eql 1