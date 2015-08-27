# routes.coffee

module.exports = (app)->
  app.get '/', (req, res)->
    console.log req
    res.send 200, 'kakaka'
