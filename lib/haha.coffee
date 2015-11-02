# 2. 嵌套两层callback
cb = (callback)->
  callback(1)

increase = (callback)->
  (num)->  
    ++num
    callback num

cb increase (num)->
  console.log num


# 1. 函数调用
func1 = ->
  console.log 'in func1'
  func2()

func2 = ->
  console.log 'in func2'

# func1()