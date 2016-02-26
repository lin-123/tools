var uploadFile = function(){
  $('#uploadFile_4 input')[0].addEventListener('change', function(){
  var file = this.files[0]
  if(!file) return console.log('没有文件')
  var xmlhttp = new XMLHttpRequest()
  xmlhttp.open("POST","ajax_test.asp",true);
  xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  xmlhttp.send("fname=Bill&lname=Gates");

  // $.ajax({
  //   type: "POST",
  //   dataType: "jsonp",
  //   url: 'localhost:3001',
  //   data: file,
  //   success: function(){
  //     console.log(arguments, 'upload file success')
  //   },
  //   error: function(){
  //     console.log(arguments,'upload file error')
  //   }
  // })
})
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
