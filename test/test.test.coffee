should = require 'should'
_ = require 'lodash'
test = require '../lib/test'

describe '验证测试', ->
  describe 'bind', ->
    it 'x should eql 0', ->
      console.log test.bindModule.getx()
      test.bindModule.getx().should.eql 0

    it 'x should eql 1', ->
      @x = 1
      _bind = test.bindModule.getx.bind(@)
      _bind().should.eql 1


  describe 'array', ->
    it 'every, some, filter, map, reduce, forEach, sort', ->
      arr = [1,2,3,2,5,3,1]
      _every = arr.every (value, index, array)->
        return value > 1
      _every.should.eql false

      _some = arr.some (value, index, array)->
        return value > 3
      _some.should.eql true

      arr.map (value)->
        console.log value++, 'map'

      _reduce = arr.reduce (preValue, currentValue, index, array)->
        return preValue+currentValue
      console.log _reduce, '_reduce'

      arr.forEach (value, index, array)->
        console.log arguments, 'forEach'

      _sort1 = arr.sort (a, b)->
        console.log arguments, 'sort'
        return a-b
      console.log _sort1, 'compare sort'

  describe 'lodash', ->
    it '_.filter', ->
      users = [
        { 'user': 'barney', 'age': 36 },
        { 'user': 'fred',   'age': 40 }
      ]

      console.log users

      # _.forEach

      console.log _.filter(users, 'age__gt36')

    xit.only 'asdfasdf',->
      image =
        name: "9.pic.jpg",
        description: "好噶好噶",
        url: "http://mobileService.qiniudn.com/9.pic.jpg",
        viewUrl: "http://mobileService.qiniudn.com/9.pic.jpg?imageView2/0/w/250",
        type: 1,
        width: 250,
        height: 99,
        department: 1,
        id: 1,
        updatedAt: 10000

      images=[]

      for i in [0..10]
        (image.id++) && (image.updatedAt++) &&(image.department%4 ++)
        images.push image

      _.chain(images)
        .countBy(obj.department)
        .value()


