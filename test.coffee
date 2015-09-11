message = 
  type : 2
  content : '...'

constants = 
  messageTypes:
    image: 1
    voice: 2
    fromCsr: 4
    text: 8
require 'mochatest'

checkMessageByVersion = (message, version)->
  content = message.content
  message.thumbnailUrl = content.thumbnailUrl
  message.thumbnailHeight = content.thumbnailHeight
  message.thumbnailWidth = content.thumbnailWidth
  message.originImageUrl = content.originImageUrl 
  
  # version 为版本号
  # 版本1， 不能收图片
  # 版本2及以前， 不能收语音
  switch
    when version < 2 and (message.type & constants.messageTypes.image) #then @transMsgImageType(message)
      message.type = constants.messageTypes.text|constants.messageTypes.fromCsr
      message.content = '给您发送了一张图片，当前版本无法查看，请及时更新。'
  
    when version < 3 and (message.type & constants.messageTypes.voice) #then @transMsgVoiceType(message)
      message.type = constants.messageTypes.text|constants.messageTypes.fromCsr
      message.content = '给您发送了一段语音，当前版本无法查看，请及时更新。'        
      
for i in [1,2,3]
  # message.type = i
  message.type = 1
  message.content = '...'
  checkMessageByVersion message, i
  console.log message,'======',i






# message.image = message.content.image
# console.log message

# transMsgImageType = (message)->
#   console.log "transMsgImageType====="
#   message.type = 1
#   message.content = '给您发送了一张图片，当前版本无法查看，请及时更新。'
  
# transMsgImageType2 = (message)->
#   console.log "transMsgImageType2====="
#   message.type = 1
#   message.content = '=======change content======'
#   # content = message.content
#   # message.thumbnailUrl = content.thumbnailUrl
#   # message.thumbnailHeight = content.thumbnailHeight
#   # message.thumbnailWidth = content.thumbnailWidth
#   # message.originImageUrl = content.originImageUrl 
  
# transMsgVoiceType = (message)->
#   console.log "transMsgVoiceType====="
#   message.type = 2
#   message.content = '给您发送了一段语音，当前版本无法查看，请及时更新。'    


# # # 版本1， 不能收图片语音
# # # 版本2， 不能收语音 
# # # 版本3， 全能
# # switch version
# #   when 1
# #     if message.type & constants.messageTypes.image then transMsgImageType(message)
# #     if message.type & constants.messageTypes.voice then transMsgVoiceType(message)
# #   when 2 
# #     if message.type & constants.messageTypes.image then transMsgImageType2(message)
# #     if message.type & constants.messageTypes.voice then transMsgVoiceType(message)
# #   when 3
# #     if message.type & constants.messageTypes.image then transMsgImageType2(message)


# for version in [1..3]
#   console.log version, 'version'
#   switch
#     when version < 2 and (message.type & 1) then transMsgImageType(message)

#     when version < 3 and (message.type & 2) then transMsgVoiceType(message)

#     when version > 1 and (message.type & 1) then transMsgImageType2(message)
#   console.log message




# transMsgType = (message)->
#   message.type = 2
  

# # msg = transMsgType message

# # console.log message
# # console.log msg

# func = ->
#   fs = require 'fs'
#   appendFile = (path, msg)->
#     fs.appendFile path, JSON.stringify(msg), (err, rs)->
#       console.log msg

#   msg = ['aaa','bbbb','nnnn']

#   json = 
#     msg : 'aaa'

#   for i in [0..2]
#     json.msg = msg[i]
#     appendFile '1.txt',json
