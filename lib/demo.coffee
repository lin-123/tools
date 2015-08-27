fun = (num)->
  console.log "args: num = #{num}"



module.exports = 
  sayHi: (fromOne, toOne)->
    console.log "#{fromOne}: Hi #{toOne}..."
    @sayGoodBye(toOne, fromOne)

  sayGoodBye: (fromOne, toOne)->
    console.log "#{fromOne}: bye bye #{toOne}..."
