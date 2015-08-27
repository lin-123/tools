module.exports = 
  readFile: (path, cb)->
    fs = require 'fs'
    fs.readFile path, 'utf8', (err, data)->
      return cb err, data
  parse: (args)->
    console.log "parse........"
    options = {}
    for arg in args
      if arg.substring(0, 2) == "--"
        arg = arg.substring(2)
        if arg.indexOf("=") != -1 
          arg = arg.split("=")
          key = arg.shift() # remove the first item of an array
          value = arg.join("=") #join() 方法用于把数组中的所有元素放入一个字符串。 key = val
          if /^[0-9]+$/.test(value)
            value = parseInt(value)
          options[key] = value
    return options  
  sayHi: ()->
    console.log "Hi...."
    return "Hi..."
