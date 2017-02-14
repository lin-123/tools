// io.sails.url = urlDomain
// io.sails.host = 'localhost'

urlDomain = 'http://192.168.19.172:7008'

// urlDomain = "http://192.168.26.249:7008"
io.sails.url = urlDomain

// io.socket.on('eventsName', function(){})
//    eventName = error, reconnect, reconnect_attempt, reconnect_failed, reconnect_error, reconnecting, reconnect_failed, connect
io.socket.on('error', function(){
  console.log('error')
})
var reconnect_attempt_count = 0
io.socket.on('reconnect_error', function(){
  console.log('reconnect_error')
})

io.socket.on('connect', function(){
  console.log('connected ...')

  io.socket.post(urlDomain + "/auth/listen",{
    roomId: '001', userName: 'userName'
  }, function(msg){
    console.log(msg, 'subscribeRoom')
  })

  io.socket.on('viewpoint', function(data){
    // url = 'http://tt.channel.baidao.com/pointview'
    console.log('da', data)
    // "http://192.168.19.172:7008"
    url = "http://192.168.26.249:7008"
    // url = 'http://192.168.19.172:7008/viewpoint'
    $.ajax({
      url: url+'/message/sendViewpoint',
      type: 'get',
      dataType: 'jsonp',
      data: data,
      success:function(data){
        console.log(arguments, asdf)
      }
    })
  })

// 'get /message/sendViewPoint'

})
