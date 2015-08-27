# mysqlService.test.coffee
sinon = require 'sinon'
should = require 'should'

require '../lib/msgRedisToMysql/server'
mysqlService = require '../lib/msgRedisToMysql/mysqlService'

describe 'mysqlService', ->
  describe.only 'insertData', ->
    message = JSON.stringify
      id: 0
      content: 'message...'
      time: new Date().getTime()
    messages = [message]
    it 'normal', (done)->
      mysqlService.insertData messages,(errs)->
        console.log errs
        done()