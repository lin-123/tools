fs = require 'fs'

logger = (status, comments, message)->
  log = JSON.stringify
    status: status
    comments: comments
    message: message
  logDir = require('path').join __dirname, "../log"
  fs.appendFile logDir, log + "\n", 'utf8'

module.exports=
  error: (comments, message)-> logger 'error', comments, message

  warn: (comments, message)-> logger 'warn', comments, message

  info: (comments, message)-> logger 'info', comments, message
    



  