var http = require('http'),
  path = require('path')
  fs = require('fs')
var router = require('./router.js')

http.createServer(function(req, res){
  console.log('request: ', req.url)
  url = req.url

  if(typeof(router[url]) === 'function')
    return router[url](req, res)

  if(url == '/') url = '/index.html'
  file_path = path.join(__dirname+url)
  var chunk = fs.readFile(file_path, function(err, chunk){
    err? res.statusCode=404 : res.write(chunk)
    res.end()
  })

}).listen(9001)