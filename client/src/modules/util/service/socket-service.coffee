'use strict'

# Reads initial information from APP_INITIAL_STATE constant that gets fetched upon bootstrapping
# Will then update the state accordingly
angular.module 'weaver.util'

.factory('Socket', ($$Promise, SOCKET_CONFIG) ->
  options =
    reconnection: true

  # Create and connect a Socket.IO socket with given path, to use later in member functions
  socket = io.connect(SOCKET_CONFIG.address, options)

  emit: (event, payload) ->
    deferred = $$Promise.defer()

    socket.emit(event, payload, (ack) ->
      deferred.resolve(ack)
    )

    deferred.promise

  on: (event) ->
    deferred = $$Promise.defer()

    socket.on(event, (data) ->
      deferred.resolve(data)
    )

    deferred.promise
)