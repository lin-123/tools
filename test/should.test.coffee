should = require 'should'

describe 'should', ->
  describe '对null, undefined 的检测', ->
    it 'Normal, null, undefined should be tested', ->
      should.not.exist(null)
      should.not.exist(undefined)
      should.exist('array')
