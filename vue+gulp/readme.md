配置一个基础的框架。
让使用者只需要 在指定目录添加代码即可完成自动化编译， 打包， 等过程。

javascript 用 coffee, es6

css 用 .css
vue 中CSS 和 js 随意

启动 gulp，  url: localhost:9001, 文件打包到 .tmp 不压缩
build: gulp build 文件打包到 dist 压缩

目录结构： 
root： 
    app
        images
        scripts
            components
            utils
            index.coffee
        styles
        index.html
    bower.json 
    gulpfile.coffee 
    gulpfile.js 
    package.json 
    readme.md