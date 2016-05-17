#nodejs+mocha: node单元测试

nodejs 开发， 初始配置

目录结构：
root
    config 配置文件夹
    lib 项目逻辑文件夹
        service 公共调用模块
    model 模型
    utils 工具集
    spec 单元测试文件夹
    index.coffee 入口文件
    Makefile
    pakage.json
    readme.md

###node调试工具， iron-node
  支持在chrome devTools中调试
  需要使用V2版本， 3.0以上版本会出现app.getPath is not function错误
