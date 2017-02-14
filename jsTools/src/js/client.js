$(document).ready(function(){
  initSize()
  // danmu()
  mockEvent()
  $("uploadFile_4 input").change(function(){
    files = this.files;
  });
});


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

var jsClass = function(){
  // 1. 使用类的一个重要原因是代码的模块化， 可以在不同的场景中实现复用。 但是类不是唯一的模块化方式
  // 2. 为了不污染全局空间， 通常设置一个对象作为全局命名空间，
  //    如， app={}, 然后将其他子模块放到app下， 如： app.utils app.views app.strings 等

  // 类和对象的区别：
  // - js中的类就是对象，
  // - 但是用{}方式定义的类没有 通常意义下的对象的 构造函数属性

  // 定义类的三个步骤
  // 1.  定义构造函数
  function Person(name, age, privateVal){
    this.name = name;
    this.age = age;

    // 构造私有属性， 可写不可读
    this.privateVal = function(){
      return privateVal
    }
  }
  // 2. 定义实例方法在构造函数的propotype 属性上
  Person.prototype = {
    toString: function(){
      this.hasOwnProperty('sayHi')
      console.log('my name is', this.name, ', age', this.age, ', privateVal', this.privateVal())
    }
  }
  // 3. 给构造函数定义类字段或类属性
  Person.sayHi = function(){
    conosle.log('hi')
  }
  var person = new Person('kakaka', 24, 'privateVal')
  console.log(person.name, person.age, person.privateVal(), 'before')
  person.privateVal = function(){return ;} //重置privateVal, 通过此实现priveteVal 不可读, 这种实现不好
  console.log(person.name, person.age, person.privateVal(), 'after')

  person.toString()

  // 原型对象是类的唯一标识，当且仅当两个类继承自同一个原型对象时， 他们才属于同一个类的实例
  var person1 = new Person('person1', 1, 'one')
  var person2 = new Person('person2', 2, 'two')

  // 原型对象是类的唯一标识，当且仅当两个类继承自同一个原型对象时， 他们才属于同一个类的实例
  //  true true ,check instanceof person and person1
  console.log(person1 instanceof Person, person1.prototype == person.prototype, ',check instanceof person and person1')
}


var mockEvent = function(){
  // js类的实现
  var MockEvent = (function(){
    // 定义类的三个步骤
    // 1.  定义构造函数
    function MockEvent(env){
      this.events = {}
      showLog(env || 'production')
    }
    // 是否显示console.log
    function showLog(env){
      (env == 'production')&&(console.log = function(){})
    }

    // 2. 定义实例方法在构造函数的propotype 属性上
    MockEvent.prototype.addEventListener = function(eventName, func){
      console.log('addEventListener', eventName, func);
      (this.events[eventName])||(this.events[eventName] = func)
    }
    MockEvent.prototype.fireEvent = function(eventName) {
      console.log(arguments, this.events)
      if(!this.events[eventName]) return;
      var args = [].slice.call(arguments)
      this.events[eventName].apply({},args)
    }
    MockEvent.prototype.removeEventListener = function(eventName){
      (this.events[eventName])&&(delete(this.events[eventName]))
    }
    // 只暴露类， 这里的私有方法外界访问不到
    return MockEvent
  }())

  // 3. 给构造函数定义类字段或类属性
  window.event = new MockEvent('test')

  event.addEventListener('newOne', function(){
    console.log('newOne', arguments)
  })

  event.fireEvent('newOne', 'this is new message...')
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

  // ===sails socket io==========================// =============================// =============================
  //sails socket 获取消息
  io.sails.host = 'localhost'
  io.sails.url = 'http://localhost:1337'

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
    console.log(data, 'message')
    msgPool.push(data)
  })
  // =====手动输入弹幕========================// =============================// =============================
  $('.damu_input_msg')[0].addEventListener('keydown', function(event){
    if(event.keyCode == 13){// enter
      msgPool.push({value: event.target.value, color: 'white'})
      msgPool.push({value: event.target.value, color: 'red'})
      msgPool.push({value: event.target.value, color: 'green'})
      event.target.value=''
    }
  })
  // =====手动输入弹幕========================// =============================// =============================

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

// document ready
var domReady = function(){
  onload = function(){
    console.log('document ready: ', arguments)
    document.querySelectorAll('p')[1].insertAdjacentHTML('beforeEnd', '<br/><h3>document ready</h3>')
  }
}

// 返回每个代码块的局部 document对象， 就是包裹此代码快的 div元素
window.utils = {
  getPartDocument: function(id){
    return document.getElementById(id)
  },
  appendElement: function(targetId, position, message){
    var str = "<p class='log'>"+message+"</p>"
    document.getElementById(targetId).insertAdjacentHTML('afterEnd', str)
  }
}