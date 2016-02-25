// rotuer
module.exports = {
  '/sayHi': function(req, res){
    res.write('this is a message...')
    res.end()
  }
}
