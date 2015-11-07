Promise = require('bluebird')
Redis   = require('ioredis')

serverError = JSON.stringify(
  code: -1
  status: 500
  message: 'Internal Server Error'
)

# bad practice! understand errror in promise and reject promise
errorHandler = (ack) ->
  (error) ->
    if error.name is 'weaver.fired.error'
      ack(error.message)
    else
      console.log(error.stack) # log this instead!
      ack(serverError)  


module.exports = (executor) ->
  (payload, ack) ->
   
    try
      executor(payload, ack)
      
      # This is weird maybe because its global! The handler is set eachtime with a different function with
      # ack built in, so at some point two promises are working, one fires exception, while handler is set to
      # other ack!
      Promise.onPossiblyUnhandledRejection(errorHandler(ack))
      Redis.Promise.onPossiblyUnhandledRejection(errorHandler(ack))

    catch error
      errorHandler(ack)(error)