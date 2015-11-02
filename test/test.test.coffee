should = require 'should'
_ = require 'lodash'
test = require '../lib/test'

describe '验证测试', ->
  describe.only 'bind', ->
    it 'x should eql 0', ->
      console.log test.bindModule.getx()
      test.bindModule.getx().should.eql 0

    it 'x should eql 1', ->
      @x = 1
      _bind = test.bindModule.getx.bind(@)
      _bind().should.eql 1


  describe 'array', ->
    it 'every, some, filter, map, reduce, forEach, sort', ->
      arr = [1,2,3,2,5,3,1]
      _every = arr.every (value, index, array)->
        return value > 1
      _every.should.eql false

      _some = arr.some (value, index, array)->
        return value > 3
      _some.should.eql true

      arr.map (value)->
        console.log value++, 'map'

      _reduce = arr.reduce (preValue, currentValue, index, array)->
        return preValue+currentValue
      console.log _reduce, '_reduce'

      arr.forEach (value, index, array)->
        console.log arguments, 'forEach'

      _sort1 = arr.sort (a, b)->
        console.log arguments, 'sort'
        return a-b
      console.log _sort1, 'compare sort'

  describe 'exportsFolder', ->
    # nodejs 载入文件模块，会搜索整个目录
    # 1.目录下包含 package.json 文件， 则通过package.json 加载
    # 2.否则， 查找 index.js 文件， 通过index.js 夹杂
    # 3.目录下没有package.json 也没有 index.js 则加载失败。 （Error: Cannot find module '../exportsFolder'）
    
    it "require('../lib/exportsFolder1') have package.json", ->
      folder = require('../lib/exportsFolder1')
      folder.should.be.Object()
      folder.hello.should.be.Function()

    it "require('../lib/exportsFolder2') have index.js", ->
      folder = require('../lib/exportsFolder2')
      folder.should.be.Object()
      folder.hello.should.be.Function()
  
  describe 'lodash', ->
    it '_.filter', ->
      users = [
        { 'user': 'barney', 'age': 36 },
        { 'user': 'fred',   'age': 40 }
      ]
        
      console.log users

      # _.forEach 

      console.log _.filter(users, 'age__gt36')
