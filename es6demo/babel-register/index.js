// require('babel-register')
var arr = [1,2,3];
arr.map(item=>console.log(item, ', arr map'))

for (var i = arr.length - 1; i >= 0; i--) {
  let letVal = 'let value';
  var varb = "varb";
  console.log(arr[i],',,,,,asdf,,,,,');
}

// 此语句访问不到 letVal 变量,  let: undefined / var: string
console.log('let:', typeof(letVal),'/ var:', typeof(varb))
