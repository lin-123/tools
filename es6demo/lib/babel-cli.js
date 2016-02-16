'use strict';

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol ? "symbol" : typeof obj; };

var arr = [1, 2, 3];
arr.map(function (item) {
  return console.log(item, ', arr map');
});

for (var i = arr.length - 1; i >= 0; i--) {
  var _letVal = 'let value';
  var varb = "varb";
  console.log(arr[i], ',,,,,asdf,,,,,');
}

// 此语句访问不到 letVal 变量,  let: undefined / var: string
console.log('let:', typeof letVal === 'undefined' ? 'undefined' : _typeof(letVal), '/ var:', typeof varb === 'undefined' ? 'undefined' : _typeof(varb));