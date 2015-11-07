module.exports = 
  start: ->
    colors  = require('colors')
    forever = require('forever-monitor');
    
    child = forever.start(['redis-server'], {
      max : 1
      silent : true
    })
            
    console.log('* Redis started and ready'.magenta)
