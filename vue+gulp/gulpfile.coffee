gulp = require 'gulp'
browserify = require 'browserify'
vueify = require('vueify')
source = require('vinyl-source-stream')
del = require 'del'
coffeeify = require 'coffeeify'

usemin = require 'gulp-usemin'
uglify = require 'gulp-uglify' #压缩js
cssmin = require 'gulp-minify-css' #压缩css
htmlmin = require 'gulp-htmlmin'

sequence = require 'run-sequence'
browserSync = require('browser-sync')
reload = browserSync.reload

# 打包js
gulp.task 'browserify', ->
  browserify
    entries: 'app/scripts/index.coffee'
    extensions: ['.js', '.coffee', '.vue']
  .transform coffeeify
  .transform vueify
  .bundle()
  .pipe(source('bundle.js'))
  .pipe gulp.dest('.tmp/scripts')

gulp.task 'cssmin', ->
  gulp.src '.tmp/styles/index.css'
    .pipe cssmin()
    .pipe gulp.dest 'dist/styles'

gulp.task 'uglify', ->
  gulp.src '.tmp/scripts/*.js'
    .pipe uglify()
    .pipe gulp.dest 'dist/scripts'

gulp.task 'htmlmin', ->
  gulp.src '.tmp/index.html'
    .pipe htmlmin({collapseWhitespace: true})
    .pipe gulp.dest 'dist'

gulp.task 'usemin', ->
  gulp.src 'app/index.html'
    .pipe usemin()
    .pipe gulp.dest '.tmp'

# 在浏览器启动服务
gulp.task 'server', ['browserify', 'usemin'], ->
  browserSync
    server:
      baseDir: '.tmp'
    port: 3000

# 实时观测
gulp.task 'watch', ->
  gulp.watch ['app/scripts/**/*.coffee', 'app/scripts/**/*.vue'], ['browserify']
  gulp.watch ['app/index.html', 'app/styles/**/*.*'], ['usemin']

  gulp.watch ['.tmp/**/*.*'], reload

gulp.task 'default', ->
  sequence 'clean', 'server', 'watch'

  console.log 'server start at 3000...'

gulp.task 'build', ->
  sequence(
    'clean',
    ['browserify', 'usemin'],
    ['cssmin', 'uglify', 'htmlmin']
  )

gulp.task 'clean', ->
  del ['.tmp', 'dist']
