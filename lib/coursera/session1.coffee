arr = [1,42,4,2,5,3,7,4,1,3,7,89,0,452,12]

swap = ()->  # (num1, num2)->
  # 利用环境
  temp = arr[i]
  arr[i] = arr[j]
  arr[j] = temp

  # temp = num1
  # num1 = num2
  # num2 = temp


console.log arr, 'befor sort...'

size = arr.length-1
for i in [0..size]
  for j in [i+1..size]
    if arr[i] < arr[j]
      # temp = arr[i]
      # arr[i] = arr[j]
      # arr[j] = temp

      swap()
      # 
      # args = [arr[i],arr[j]]
      # swap.apply(this, args)
      # swap.call(this,

console.log arr, 'after sort...'
