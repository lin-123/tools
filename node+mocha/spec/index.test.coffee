mocha = require 'mocha'
should = require 'should'
sinon = require 'sinon'

index = require '../index'
describe 'start', ->
  it 'should say hi kakaka', ->
    index.sayhi.should.be.Function()

  it 'should return 2', ->
    index.add(1,1).should.eql 2