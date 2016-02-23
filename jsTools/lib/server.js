var app = require('express')()
var htmlFile = require('path').join(__dirname, "../resource/0jsNative.html")
app.get('/',function (req, res){
  // # 返回一个html网页
  res.sendFile(htmlFile )
})
app.get('/getString', function(req, res){
  res.send('this is a string')
})
app.listen(3001)