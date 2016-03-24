# 用function的方式构建gruntfile配置文件
# 官方网站：  http://www.gruntjs.net/configuring-tasks
#
module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # 每一个task
    coffee:
      # 单个文件编译
      # 'path/to/result.js': 'path/to/source.js'

      # 对每个文件编译到当前目录下
      files:
        expand: true
        cwd: "src/"
        src: ["*.coffee", "folder1/*.coffee"]
        dest: "src"
        extDot: 'last'
        ext: ".js"

    jade:
      compile:
        options:
          pretty: true
          data:
            debug: true
        files:[
          expand: true
          cwd: "src/"
          src: "**/*.jade"
          dest: "src"
          extDot: 'last'
          ext: ".html"
        ]


  # 引入插件
  grunt.loadNpmTasks('grunt-contrib-jade')
  grunt.loadNpmTasks('grunt-contrib-coffee')


  grunt.registerTask('default', ['coffee', 'jade'])


#package.json
  # "devDependencies": {
  #   "grunt": "~0.4.5",
  #   "grunt-contrib-coffee": "^1.0.0",
  #   "grunt-contrib-jade": "^1.0.0",
  #   "grunt-contrib-jshint": "~0.10.0",
  #   "grunt-contrib-nodeunit": "~0.4.1",
  #   "grunt-contrib-uglify": "^0.5.1"
  # }
