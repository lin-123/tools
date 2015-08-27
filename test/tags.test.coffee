expect = require('chai').expect
tags = require("../lib/tags.js")
fs = require 'fs'

describe "Tags" , ()-> #描述测试的那个模块
  before ()->
    console.log "=====before========="

  beforeEach (done)->
    console.log "======beforeEach======"
    setTimeout(()->
      console.log 'setTimeout...'
      done()
    ,1000)
  describe "#readFile", ->
    it 'test fs.readFile',(done)->
      tags.readFile './1.txt',(err, data)->
        console.log "err: #{err}" unless err is null
        console.log "data: #{data}"
        done()
        
  describe "#parse()",()->
    it 'should parse long formed tags', ()->
      args = ['--depth=4','--hello=world']
      results = tags.parse(args)
      expect(results).to.have.a.property('depth',4)
      expect(results).to.have.a.property('hello','world')

  describe "#sayHi", ()->
    it 'should return Hi',()->
      results = tags.sayHi()
      expect(results).to.equal('Hi...')
  after ()->
    console.log "=========after========"