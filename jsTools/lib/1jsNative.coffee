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

  console.log sam, sam.move
  sam.move()
  tom.move(44)
  tom.song()

# 原生 数组操作，
arrayOpt = ->
  arr = [1,2,3,2,5,3,1]
  console.log 'arr=', arr
  _every = arr.every (value, index, array)-> value > 1
  console.log 'Array.every value>1: ', _every

  _some = arr.some (value, index, array)-> value > 3
  console.log 'Array.some value>3: ', _some

  # 返回map后的array
  _map = arr.map (value, index, array)-> value++
  console.log 'Array.map value++: ', _map

  # 不返回
  arr.forEach (value, index, array)->
    console.log 'Array.forEach: ', arguments
    value++

  _reduce = arr.reduce (preValue, currentValue, index, array)->
    return preValue+currentValue
  console.log 'Array.reduce: ', _reduce

  _sort1 = arr.sort (a, b)-> return a-b
  console.log 'Array.sort:', _sort1
