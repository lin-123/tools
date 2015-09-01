pool = require './db_pool'
logger = require '../../utils/log'

module.exports = 
  getConnection: (cb)->
    pool.getConnection (err, conn)->
      if err
        console.log err, err.stack
        logger.error "#{__filename}.getConnection pool.getConnection callback err", err
        cb err, null
      cb null, conn

  releaseConnection: (conn)->
    pool.releaseConnection conn 