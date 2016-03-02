// rotuer
module.exports = {
  '/sayHi': function(req, res){
    res.write('this is a message...')
    res.end()
  },
  '/upload': function(req, res){
    console.log(req)
    res.end('recive file')
  }
}
