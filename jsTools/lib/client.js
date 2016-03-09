$(document).ready(function(){
  if(io){
    // var port = 3000 //1337
    // var socket = io.connect('http://localhost:'+port+'/channel_1')
    // console.log(socket)


    //  1337
    var socket1 = io.connect('http://localhost:1337')
    console.log(socket1)
    socket1.on('disconnect', function(){
      console.log('disconnect')
    })

    socket1.on('connect', function(){
      console.log('connect', arguments)

    })
    socket1.on('message', function(data){
      console.log('receive message: ', arguments)
    })

    socket1.on('text', function(data){
      console.log('receive text: ', arguments)
      socket1.emit('text', 'adsf')
    })

  }
})

    // socket.on('sendMessageToRoom', function(data){
    //   console.log('receive data: ', data)
    // })
    // socket.on('joinOrLeave', function(){
    //   console.log('joinOrLeave, ', arguments)
    // })

$(document).ready(function(){
  $("uploadFile_4 input").change(function(){
    files = this.files;
  });
});
uploadFile = function (){
  // var files = [];
  // $('#uploadFile_4 input')[0].addEventListener('change', function(){
  // var file = this.files[0]
  // if(!file) return console.log('没有文件')

  $("#upload-btn").click(function(){
    var fd = new FormData();
    for (var i = 0; i < files.length; i++) {
      fd.append("file", files[i]);
    }
    $.ajax({
      url: "/upload/",
      method: "POST",
      data: fd,
      contentType: false,
      processData: false,
      cache: false,
      success: function(data){
        console.log(data);
      }
    });
  });
}

var ajaxHttpRequest = function(){
  // http request
  // jsonp 原理
  // http://www.cnblogs.com/dowinning/archive/2012/04/19/json-jsonp-jquery.html
  // jquery api:  http://api.jquery.com/
  // =====可跨域=====
  $.ajax({
    url: "http://localhost:1337/user",
    type: 'get',
    dataType: 'jsonp',
    cache: true,  //去掉 _=1234 的时间戳字段
    success: function(){
      console.log('get user success, ', arguments)
      document.querySelector('#response_data').contentText = JSON.stringify(arguments)
    }
  })
  // jQuery.get( url [, data ] [, success ] [, dataType ] )

  $.get("http://localhost:1337/user", function(result){
    console.log(result)
  }, 'jsonp')

  // ==不可跨域-----
  // jQuery.getJSON( url [, data ] [, success ] )
  $.getJSON("http://localhost:1337/user", function(result){
    console.log(result)
  })
}

// document ready
var domReady = function(){
  onload = function(){
    console.log('document ready: ', arguments)
    document.querySelectorAll('p')[1].insertAdjacentHTML('beforeEnd', '<br/><h3>document ready</h3>')
  }
}
