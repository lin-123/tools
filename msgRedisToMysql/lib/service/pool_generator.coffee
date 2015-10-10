poolModule = require('generic-pool')

mockPool = []
i=0
pool = poolModule.Pool
  name: 'mockPool'
  create: (callback)->
    # console.log 'in create pool method ,,,', mockPool.length
    console.log 'destroy,,,,,,,'
    mockPool.push ++i
    console.log mockPool
    callback null, i

  destroy: (mockPool)->
    console.log 'destroy,,,,,,,'
    "mockPool.shift()"
  
  max: 10
  min: 2
  idleTimeoutMillis:1000
  log: true

module.exports = pool 
  # acquire: ()->
  #   return 