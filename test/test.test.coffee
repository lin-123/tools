should = require 'should'

describe '验证测试', ->
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
    
