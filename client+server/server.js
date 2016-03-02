var http = require('http'),
  path = require('path')
  fs = require('fs')
var router = require('./router.js')

http.createServer(function(req, res){
  console.log('request: ', req.url)
  url = req.url

  // 路由到下层
  if(typeof(router[url]) === 'function')
    return router[url](req, res)

  // 访问文件
  if(url == '/') url = '/index.html'
  file_path = path.join(__dirname+url)
  var chunk = fs.readFile(file_path, function(err, chunk){
    res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'})

    msg = err?'没找到对应文件， 请确认文件名是否正确':chunk
    res.write(msg,'utf8')

    res.end()
  })

}).listen(9001)
