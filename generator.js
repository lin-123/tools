function* gen(x){
  console.log('before yield..', x)
  var y = yield x + 2;
  console.log('after yield..', y, x)

  var z = yield y + 10;

  return z;
}

var g = gen(1);
// { value: 3, done: false }
// first yield
console.log(g.next())
// { value: 12, done: false }
console.log(g.next(2))
// { value: 3, done: true }
console.log(g.next(3))



//
function first () {
  function* gen(x){
    console.log('before yield..', x)
    var y = yield x + 2;
    console.log('after yield..', y, x)
    return y;
  }

  var g = gen(1);
  // { value: 3, done: false }
  // first yield
  console.log(g.next())
  // { value: undefined, done: true }
  // just return; 2 is input value for return of 'yield x+2'
  console.log(g.next(2))
}
