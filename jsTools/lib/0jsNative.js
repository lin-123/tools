// 连mysql数据库
function connectMysql(){
  mysql = require('mysql')
  // 配置信息
  var conn = mysql.createConnection({
    host: '192.168.26.239',
    user: 'root',
    password: 'raspberry',
    database: 'graduation'
  });

  conn.connect(function(){
    console.log(arguments, ',connect success')
    conn.query('select * from article', function(err){
      console.log('query success...')
    })
  })
  conn.end()
}