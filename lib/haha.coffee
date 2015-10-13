func1 = ->
  console.log 'in func1'
  func2()

func2 = ->
  console.log 'in func2'

func1()