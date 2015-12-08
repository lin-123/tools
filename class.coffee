
class A
  constructor: ->
    @name = 'a'
  say: ->
    console.log 'hello'

console.log new A()
a = new A()

module.exports = a
# a = new A()
# a.say()
# console.log a
