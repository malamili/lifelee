winston = require('winston')                        # Logging library

# Easy date formatting library
moment = require('moment')

# Return timestamp correctly formatted
timestamp = ->
  moment().format("YYYY-MM-DD HH:mm:ss")
  
  
# Return complete formatted string
formatter = (options) ->
  time = options.timestamp()
  level = options.level.toUpperCase()
  message = if options.message? then options.message else ''
  object = if options.meta? && Object.keys(options.meta).length != 0 then ('\n\t'+ JSON.stringify(options.meta)) else ''

  #time + ' | ' + level + ' | ' + message + object
  message + object

  
# Return logger
module.exports = 
  new (winston.Logger)(
    transports: [new (winston.transports.Console)({timestamp, formatter})]
  )