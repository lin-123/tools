_ = require 'lodash'
images = [
  {
  name: "a",
  description: "aa",
  url: "asdf",
  viewUrl: "asdf",
  type: 1,
  width: 12,
  height: 123,
  department: 1,
  id: 10,
  updatedAt: "2015-10-29T09:54:20.000Z"
  },
  {
  name: "a",
  description: "aa",
  url: "asdf",
  viewUrl: "asdf",
  type: 1,
  width: 12,
  height: 123,
  department: 1,
  id: 9,
  updatedAt: "2015-10-29T08:54:20.000Z"
  },
  {
  name: "a",
  description: "aa",
  url: "asdf",
  viewUrl: "asdf",
  type: 1,
  width: 12,
  height: 123,
  department: 1,
  id: 8,
  updatedAt: "2015-10-29T07:54:20.000Z"
  },
  {
  name: "a",
  description: "aa",
  url: "asdf",
  viewUrl: "asdf",
  type: 1,
  width: 12,
  height: 123,
  department: 1,
  id: 7,
  updatedAt: "2015-10-28T07:54:20.000Z"
  },
  {
  name: "9.pic.jpg",
  description: "好噶好噶",
  url: "http://mobileService.qiniudn.com/9.pic.jpg",
  viewUrl: "http://mobileService.qiniudn.com/9.pic.jpg?imageView2/0/w/250",
  type: 1,
  width: 250,
  height: 99,
  department: 1,
  id: 1,
  updatedAt: "2015-10-28T06:59:49.000Z"
  },
  {
  name: "a",
  description: "aa",
  url: "asdf",
  viewUrl: "asdf",
  type: 1,
  width: 12,
  height: 123,
  department: 2,
  id: 3,
  updatedAt: "2015-10-28T06:50:20.000Z"
  },
  {
  name: "a",
  description: "aa",
  url: "asdf",
  viewUrl: "asdf",
  type: 1,
  width: 12,
  height: 123,
  department: 2,
  id: 4,
  updatedAt: "2015-10-28T04:50:20.000Z"
  },
  {
  name: "a",
  description: "aa",
  url: "asdf",
  viewUrl: "asdf",
  type: 1,
  width: 12,
  height: 123,
  department: 4,
  id: 11,
  updatedAt: "2015-11-29T08:54:20.000Z"
  },
  {
  name: "a",
  description: "aa",
  url: "asdf",
  viewUrl: "asdf",
  type: 1,
  width: 12,
  height: 123,
  department: 4,
  id: 5,
  updatedAt: "2015-10-28T04:50:20.000Z"
  }
]
result = []
_.chain(images)
  .groupBy (obj)-> obj.department
  .forEach (n)->
    result = result.concat n.slice 0, 3

result = _.sortBy result, (obj)->
  console.log _.isDate obj.updatedAt
  -obj.updatedAt

console.log result

# a=[
#   {time:4, flag:3}
#   {time:3, flag:1}
#   {time:2, flag:3}
#   {time:2, flag:2}
#   {time:1, flag:1}
# ]
# obj1 = []
# res = _.chain(a)
#   .groupBy (obj)-> obj.flag
#   .forEach (n)->
#     obj1 = obj1.concat n.slice 0, 2

# res = _.sortBy obj1, (obj)-> -obj.time

# console.log obj1, 'asdfasdf', res
