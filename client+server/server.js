var app = require('express')()

app.get('/', function(req, res){
  var _file = require('path').join(__dirname, "./index.html")
  res.sendFile(_file)
})

var port = 9001
app.listen(port, function(){
  console.log('server start at localhost:'+port)
})