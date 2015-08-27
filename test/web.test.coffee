# require('coffee-script/register')
mocha = require 'mocha'
request = require('supertest')
express = require('express')
should = require('should')
app = express()

# console.log app.get()

app.get '/user', (req, res)->
  # 'kakaka' save in res.text
  # 200 save in statusCode
  res.send 200, 'kakaka' 


message = 
  text: 'kakaka'

app.get '/user2', (req, res)->
  # message save in res.body
  res.send message

describe 'webTest, GET /user', ->
  it 'should response kakaka in web text', (done)->
    request(app).get('/user').end (err, res)->
      throw err if err
      res.text.should.eql 'kakaka' 
      done()

  it 'should response kakaka in web body ', (done)->
    request(app).get('/user2').end (err, res)->
      res.body.text.should.eql 'kakaka'
      res.body.should.Object()
      done()