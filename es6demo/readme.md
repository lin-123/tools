es6 试水

使用babel转码， 
#1. babel-register
    1. npm install babel-register
    2. require('babel-register')
# > 需要注意的是，babel-register只会对require命令加载的文件转码，而不会对当前文件转码。另外，由于它是实时转码，所以只适合在开发环境使用。

#2. bable-cli 
```
    1. npm install --save-dev babel-cli
    2. 改写pakage.json    
        {
          // ...
          "devDependencies": {
            "babel-cli": "^6.0.0"
          },
          "scripts": {
            "build": "babel src -d lib"
          },
        }
    3. npm run build
```