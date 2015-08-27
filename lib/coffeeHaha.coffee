# coffeeHaha.coffee

# 在coffee 中插入javascript 用反引号括起来
insertJS = ->
  fun1(1)
  `
  // 在coffee 中插入javascript 用反引号括起来
  function fun1(num){
    console.log("call fun1: num = " + num)
  }
  `
# 类 继承 super

classes = ->
  class Animal
    constructor: (@name) ->

    move: (meters) ->
      console.log @name + " moved #{meters}m."

  class Snake extends Animal
    move: ->
      console.log "Slithering..."
      super 5

  class Horse extends Animal
  # 重载
  Horse::move = (meters)-> 
    console.log "Horse move..."
    super meters #调用父方法

  Horse::song = ()->
    console.log "Horse Horse Horse songing..."

  sam = new Snake "Sammy the Python"
  tom = new Horse "Tommy the Palomino"

  sam.move()
  tom.move(44)
  tom.song()



