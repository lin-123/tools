$(document).ready(function(){
  initSize()
  // danmu()
  mockEvent()
  $("uploadFile_4 input").change(function(){
    files = this.files;
  });
});

var mockEvent = function(){
  var MockEvent = function(){
    this.events = {}
  }

  MockEvent.prototype.addEventListener = function(eventName, func){
    if(this.events[eventName]){
      this.events[eventName] = func
    }
  }

  MockEvent.prototype.fireEvent = function(eventName) {
    if(!this.events[eventName]) return;
    var args = [].slice.call(arguments)
    this.events[eventName].apply({},args)
  }

  MockEvent.prototype.removeEventListener = function(eventName){
    if(!this.events[eventName]) return;
    delete(this.events[eventName])
  }


  var event = new MockEvent()
  event.addEventListener('newOne', function(){
    console.log('newOne', arguments)
  })


  return MockEvent
}


var danmu = function(){
  // jquery 设置动画
  //
  // 接受socket返回消息， 显示弹幕， 从左向右移动，或从右向左移动， 溢出直播室后消失
  // 消息车队列， 每当有新消息时从队列中拉出一个消息车， 运载消息进入弹幕
  //  1.一行最多四辆车
  //  2.一共5行

  //  $(selector).animate(styles,speed,easing,callback)
  window.msgPool=[]
  window.msgBus = []
  window.ways = []

  var maskWidth = $('.damu_mask')[0].getBoundingClientRect().width
  var maskHeight = $('.damu_mask')[0].getBoundingClientRect().height
  var delay = 3000 //弹幕显示时间
  var busLimit = 25, currentBus=0
  var getMsgClork = 200 //pop消息时间间隔

  //sails socket 获取消息
  io.sails.host = 'localhost'
  io.sails.url = 'http://localhost:1337'
  console.log(io.socket)
  io.socket.on('connect', function(){
    console.log('connected ...')

    io.socket.post("http://localhost:1337/message/joinInRoom",{
      userName:'userName', roomName:'roomName'
    }, function(msg2){
      console.log("joinRoomBtn click callback")
      console.log(msg2)
    })

    io.socket.post("http://localhost:1337/join",{ roomName:'roomName'}, function(msg2){
      console.log("joinRoomBtn click callback")
      console.log(msg2)
    })
  })
  io.socket.on('message', function(data){
    // console.log(data, 'message')
    msgPool.push(data)
  })

  // get msg pool
  var shiftMsgSchedule = setInterval(function(){
    if(msgPool.length>0){
      showDamu(msgPool.shift())
    }else{
      ways=[]
      msgBus.splice(0, 25)
    }
  },getMsgClork)

  function showDamu(msg){
    var el = getBus()
    if(!el) return msgPool.unshift(msg);
    makeupEl(el, msg)
    $('.damu_mask')[0].appendChild(el)
    var thisDelay = setTimeout(function(){
      // console.log(el.id.split('_')[1], el.id, '======')
      ways[el.id.split('_')[1]] = -1
      clearTimeout(thisDelay)
    }, delay*el.getBoundingClientRect().width/maskWidth + 300)

    $(el).animate({left:maskWidth+'px'}, delay, function(){
      el.id=''
      msgBus.push(el)
    });
  }

  // 消息车队， 保持15辆常用车
  function getBus(msg){
    if(msgBus.length==0&&currentBus<busLimit){
      var new_el = document.createElement('div')
      new_el.className = 'damu_msg';
      currentBus++;
      msgBus.push(new_el);
    }
    if(msgBus.length==0&&currentBus>=busLimit) return;
    return msgBus.pop()
  }

  // 给标签添加样式
  function makeupEl(el, msg){
    el.innerText = msg.value
    var width = el.getBoundingClientRect().width

    el.style['min-width'] =  width + 'px'
    el.style.left = -width + 'px'
    el.style.color = msg.color || 'white'

    var top = getWay(width)
    el.id = 'msg_'+top
    if(top<0){
      msgBus.push(el);
      return;
    }
    el.style.top = top*maskHeight/15+'px'
    return el
  }

  // 查询哪条路不堵车
  function getWay(width){
    var result = -1, waysLength = ways.length;
    for(var i=0; i<waysLength; i++){
      if((ways[i]<0)&&(ways[i]=1)&&(result=i) ) break;
    }
    (result<0)&&(waysLength<10)&&(ways.push(1))&&(result = waysLength);
    return result
  }
}

var uploadFile = function (){
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


initSize = function(){
  // 根据窗口的宽度设置fontSize的单位值
  // 针对嵌套的窗口或手机上横屏状态 重置fontSize的单位值
  document.documentElement.style.fontSize = 100 * innerWidth / 320 + 'px';
  addEventListener('load', function() {
    setTimeout(function(){
        document.documentElement.style.fontSize = 100 * innerWidth / 320 + 'px';
    }, 480);
    // 判断窗口是否在一个框架中
    var isInApp = (window.self != window.top);
    if (!isInApp) {
        window.parent.postMessage({name: 'web:inject', token: Math.random().toString(), usertype: 1}, '*');
    }
  })
  addEventListener('orientationchange', function() {
      document.documentElement.style.fontSize = 100 * innerWidth / 320 + 'px'
  });
}