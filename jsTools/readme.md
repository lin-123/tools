js 使用工具集

#运行方式
`runFunc=functionName node xx.js`
`runFunc=functionName coffee xx.coffee`

1. resource/0jsNative.html html页面
    lib/client.js   引用js
    lib/server.js   后台server

##lib  
2. 1jsNative.coffee  原生js使用， 只不过用的是coffee-script 
  1，2 都是对原生js的使用， 只是一个是coffee， 一个是js
3.  nodejs.coffee nodejs环境
4. es6.js 编辑es6代码， 需要通过es6.src.js 编译后运行， 即：`node lib/es6.src.js `

