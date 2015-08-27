express = require 'express'
app = express()

routes = require('./routes')(app)

baseUrl = express()

app.get '/',(req, res)->
  res.send 'kakaka'


app.use '/base', baseUrl

app.listen(3001)