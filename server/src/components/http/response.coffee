module.exports = 
  OK: (arg) ->
    if arg? then message: arg, status: 200 else status: 200
  
  forbidden: ->
    status: 403