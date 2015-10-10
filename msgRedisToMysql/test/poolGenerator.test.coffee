# poolGenerator.test.coffee
sinon = require 'sinon'
should = require 'should'

poolGenerator = require '../lib/service/pool_generator'

describe 'pool_generator', ->

  show = {}
  show.poolStatus = (pool)->
    poolInfo = JSON.stringify
      serviceName: pool.getName()
      acquire: pool.acquire()
      available: pool.availableObjectsCount()
      waitingClients: pool.waitingClientsCount()
      poolSize: pool.getPoolSize()
      maxPoolSize: pool.getMaxPoolSize()

    console.log poolInfo

  it 'get pool ', (done)->
    # console.log '======get pool==========', poolGenerator
    cycle = setInterval ->
      # console.log '-------setInterval------'
      poolGenerator.acquire (err, client)->
        console.log err, client
        console.log '======poolGenerator.acquire return =========='
        show.poolStatus poolGenerator 
      
        console.log '======poolGenerator.release  =========='
        poolGenerator.release client
    ,1000

    setTimeout ->
      clearInterval(cycle)
      done()
    ,9000
    # poolGenerator.release (poolGenerator)