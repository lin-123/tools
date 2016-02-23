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

// document ready
var domReady = function(){
  onload = function(){
    console.log('document ready: ', arguments)
    document.querySelectorAll('p')[1].insertAdjacentHTML('beforeEnd', '<br/><h3>document ready</h3>')
  }
}

var thenjs = function(){
  function task(arg, callback) { // 模拟异步任务
    Thenjs.nextTick(function () {
      callback(null, arg);
    });
  }

  Thenjs(function (cont) {
    task(10, cont);
  })
  .then(function (cont, arg) {
    console.log(arg);
    cont(new Error('error!'), 123);
  })
  .fin(function (cont, error, result) {
    console.log(error, result);
    cont();
  })
  .each([0, 1, 2], function (cont, value) {
    task(value * 2, cont); // 并行执行队列任务，把队列 list 中的每一个值输入到 task 中运行
  })
  .then(function (cont, result) {
    console.log(result);
    cont();
  })
  .parallel([
    function(cont){
      setTimeout(function(){
        console.log('parallel task 1')
        cont(null, 'task1')
      }, 1000);
    },
    function(cont){
      setTimeout(function(){
        console.log('parallel task 2')
        cont(null, 'task2')
      }, 1050);
    }
  ])
  .then(function(cont, result){
    console.log(result)
    cont('error')
  })
  .series([ // 串行执行队列任务
    function (cont) { task(88, cont); }, // 队列第一个是异步任务
    function (cont) { cont(null, 99); } // 第二个是同步任务
  ])
  .then(function (cont, result) {
    console.log(result);
    cont(new Error('error!!'));
  })
  .fail(function (cont, error) {
    console.log(error);
    console.log('DEMO END!');
  });


  // 模拟promise.race 的功能
  function race(){
    Thenjs.parallel([
      function(cont){
        setTimeout(function(){
          console.log('parallel task 1')
          cont(null, 'task1')
        }, 1000);
      },
      function(cont){
        setTimeout(function(){
          console.log('parallel task 2')
          cont(null, 'task2')
        }, 1050);
      }
    ])
    .then(function(cont, res){
      console.log(arguments, 'then')
    })
    .fin(function(){
      console.log(arguments, 'finally')
    })
    .fail(function(cont, res){
      console.log(arguments, 'fail')
    })
  }
}