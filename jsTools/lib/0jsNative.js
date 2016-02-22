// document ready
function domReady(){
  onload = function(){
    console.log('document ready: ', arguments)
    document.querySelectorAll('p')[1].insertAdjacentHTML('beforeEnd', '<br/><h3>document ready</h3>')
  }
}

function thenjs(){
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