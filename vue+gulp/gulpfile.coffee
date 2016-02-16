gulp = require "gulp"
browserify = require "browserify"
vueify = require("vueify")
coffeeify = require "coffeeify"
babelify = require 'babelify'

source = require("vinyl-source-stream")

del = require "del"

browserSync = require("browser-sync")
reload = browserSync.reload
runSequence = require('run-sequence')

usemin = require "gulp-usemin"
uglify = require "gulp-uglify" #压缩js
cssmin = require "gulp-minify-css" #压缩css
imagemin = require 'gulp-imagemin'
htmlmin = require 'gulp-htmlmin'

config =
  entryFile: "#{config.srcFolder}/scripts/index.coffee"
  srcFolder: "./app"
  tmpFolder: "_tmp"
  releaseFolder: "_dist"

  port: 9001

targetFolder = config.tmpFolder

# 打包js, js兼容coffee, es6
gulp.task "browserify", ->
  browserify
    entries: [config.entryFile]
    extensions: ['.js', '.coffee', '.vue']
  .transform coffeeify
  .transform babelify
  .transform vueify
  .bundle()
  .pipe(source("bundle.js"))
  .pipe gulp.dest("#{targetFolder}/scripts")

# 压缩
gulp.task 'images', ->
  gulp.src "#{config.srcFolder}/images/**/*"
  .pipe imagemin {optimizationLevel: 5, progressive: true, interlaced: true}
  .pipe gulp.dest "#{targetFolder}/images"

gulp.task "cssmin", ->  gulp.src("#{targetFolder}/styles/*.css").pipe(cssmin()).pipe gulp.dest "#{targetFolder}/styles"
gulp.task "uglify", ->  gulp.src("#{targetFolder}/scripts/*.js").pipe(uglify()).pipe gulp.dest "#{targetFolder}/scripts"
gulp.task "htmlmin", -> gulp.src("#{targetFolder}/index.html").pipe(htmlmin({collapseWhitespace: true})).pipe gulp.dest "#{targetFolder}"

gulp.task "usemin", ->  gulp.src("#{config.srcFolder}/index.html").pipe(usemin()).pipe gulp.dest "#{targetFolder}"

# 实时观测
gulp.task "watch", ->
  gulp.watch ["#{config.srcFolder}/scripts/**/*.*"], ["browserify"]

  gulp.watch ["#{config.srcFolder}/index.html", "#{config.srcFolder}/styles/**/*.css"], ["usemin"]

  gulp.watch ["#{config.srcFolder}/images/**/*"], ['images']
  gulp.watch ["#{targetFolder}/**/*"], reload

# 在浏览器启动服务
gulp.task "server", ->
  browserSync
    server:
      baseDir: "#{targetFolder}"
    port: config.port
  console.log "server start at #{config.port}..."

gulp.task "build", ->
  targetFolder = config.releaseFolder
  runSequence(
    'clean',
    ["browserify", "usemin", 'images'],
    ["cssmin", "uglify", 'htmlmin']
  )
gulp.task 'dev', ->
  targetFolder = config.tmpFolder
  runSequence(
    'clean',
    ["browserify", "images", "usemin"],
    ['server', "watch"]
    )

gulp.task "default", ['dev'], -> console.log '=======run task======='

gulp.task "clean", (arg)-> del [targetFolder]