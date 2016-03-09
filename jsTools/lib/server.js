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


//
// var server = require('http').createServer();
// var io = require('socket.io')(server);

// io.of('/channel_1').on('connection', function(socket){
//   console.log('socket')
//   socket.emit('text', 'channel_1 send message')
//   socket.join('channel_1')
//   io.to('channel_1').emit('text', 'some event')
//   // socket.broadcast('text', 'channel_1 broadcast message')
//   console.log(arguments, 'channel_1 connected')
// })

// io.of('/channel_2').on('connection', function(){
//   console.log(arguments, 'channel_2 connected')

// })

// // var count = 1
// // io.sockets.on('connection', function (socket) {
// //   console.log('socket connected');
// //   count++
// //   if(count>3)
// //     // 向所有的socket连接发送消息
// //     io.emit('text', 'there are three listeners...')
// //   socket.on('disconnect', function () {
// //       console.log('socket disconnected');
// //   });
// //   socket.on('text', function(){
// //     console.log('text')
// //   })

// //   // 向单个socket连接发消息
// //   socket.emit('text', 'wow. such event. very real time.');

// // });

// server.listen(3000);