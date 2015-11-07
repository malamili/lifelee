colors = require('colors')
DefaultCtrl = require('default.ctrl')

# This is the main entry point of any new socket connection.
module.exports =

  # Define a route function that will take a message signature in the form of
  # a:b:c, and construct a route for that signature using the auth function as auth["a"]["b"]["c"]
  # and similarly for the controller function to be ctrl["a"]["b"]["c"]
  # This procedure gets called on each new connection! TODO Check time penalty
  (socket) -> (key, operation) ->

    try
      Controller = require('controller/' +  key + '.ctrl')
      ctrl = new Controller()
    catch error
      # No controller found, so initiate with default controller
      try
        Entity = require('entity/' + key + '.entity')
        ctrl = new DefaultCtrl(key, Entity)
      catch error
        console.log(('Error: ' +key+ ':' +operation+ ' route has no controller or entity.').red)

    # Actual Socket route
    socket.on(key + ':' + operation, (payload, ack) ->
      ctrl[operation](payload, socket, ack)
    )