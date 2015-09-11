# # CallInfoController.coffee
# logger = require '../utils/log_utils'
# ytx_webservice = require('ytx-service-config')

# errHandleForPhoneNotFaze = (msg, res)->
#   res.send 
#     'result':0
#     'msg':msg

# errHandleForGetPhoneFaze = (cusName, res)->
#   res.send 
#     "result": -1
#     "ytxUserName" : cusName
#     "cusId":null

# module.exports = 
#   phoneNotfaze: (req, res)->
#     token = req.query.token
#     # getUsernameByToken token, res, (cusName)->  
#     ytx_webservice.more.getUserInfo
#       args:{token:token}
#       callback: (err, result) ->
#         if err 
#           return errHandleForPhoneNotFaze 'Internal err', res
#         unless result?.body?.user?.username
#           return errHandleForPhoneNotFaze 'Username not exists', res

#         ytx_webservice.crmService.phoneNotfaze
#           args: req.body
#           callback: (err, result)->
#             if err 
#               return errHandleForPhoneNotFaze 'Internal err', res
#             res.send result.body
        
#   getPhoneFaze: (req, res)->
#     token = req.query.token
#     ytx_webservice.more.getUserInfo
#       args:{token:token}
#       callback: (err, result) ->
#         if err 
#           return errHandleForGetPhoneFaze req.body.cusName res
#         unless result?.body?.user?.username
#           return errHandleForGetPhoneFaze req.body.cusName, res

#       ytx_webservice.crmService.getPhoneFaze
#         args: req.body
#         callback: (err, result)->
#           if err 
#             return errHandleForGetPhoneFaze req.body.cusName res
            
#           res.send result.body