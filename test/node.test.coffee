sinon = require 'sinon'
should = require 'should'

describe 'node', ->
  describe '默认属性', ->
    it 'getter and setter', ->
      user =
        name: 'kakaka'

      # 定义一个obj 的 默认getter setter 属性， 并对其命名
      user.__defineGetter__ 'getName', -> @name
      user.__defineSetter__ 'setName', (name)-> @name = name

      user.getName.should.eql 'kakaka'

      user.setName = 'hlj'

      user.getName.should.eql 'hlj'

    it 'defineProperty', ->
      obj = {}
      # 官方解释：
      # The Object.defineProperty() method defines a new property directly on an object,
      # or modifies an existing property on an object, and returns the object.
      #
      # 为一个obj 添加默认属性
      # Object.defineProperty obj, propertyName, descriptor
      #
      # descriptor 对此属性的描述，
      #  包括： configurable, emurable, value, writable, get, set
      #

      # 可读写
      Object.defineProperty obj, 'ha', {
        writable: true
      }
      (!obj.ha).should.ok
      obj.ha = 'kakaka'
      obj.ha.should.eql 'kakaka'

      # 只读
      Object.defineProperty obj, 'readOnly', {
        writable: false
        value: 'readOnly'
      }
      obj.readOnly = 'nnnn'
      obj.readOnly.should.eql 'readOnly'


      obj1 = {}
      _value = 1
      Object.defineProperty obj1, 'neo', {
        set: (value)-> _value = value
        get: ->
          # get 获取外部变量
          _value
      }
      obj1.neo = 'haha'
      obj1.neo.should.eql 'haha'

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
