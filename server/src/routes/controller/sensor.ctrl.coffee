Sensor = require('entity/sensor.entity')
sensorReader = require('720/sensor') # Reading sensor information
module.exports =

  class SensorCtrl extends require('default.ctrl')
    getIdentifier: ->
      'sensor'

    getType: ->
      require('entity/sensor.entity')

    create: (payload, socket, ack) ->
      sensor = new Sensor()
      sensor.create(payload).bind(@).then((id) ->
        socket.broadcast.emit('sensor:created', sensor)

        # Read values if live
        sensorReader(sensor, socket) if payload.live

        ack(id)
      )