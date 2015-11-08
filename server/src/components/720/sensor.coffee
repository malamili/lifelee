request = require('request')
Measurement = require('entity/measurement.entity')

module.exports = (sensor, socket) ->

  # Credentials
  url  = 'https://hackathon.720.fi/latest_measurements'
  user = 'hackathon_1@720.fi'
  pass = 'AEC_h4Xx!'

  # Read a value
  readSensorValue = (callback) ->
    # Do the request
    request(url, {'auth': {'user': user, 'pass':pass}} , (error, response, body) ->
      # Convert to JSON
      if body?
        body = JSON.parse(body)

        # Read out the CO2 value of the Node at Metsänpojankuja 1, Space 1
        node = body.data.nodes['bb69a636-c0e6-451c-9cf4-61cd4c0b366a']
        co2  = node.measurements.co2

        callback(co2.value)
    )

  # Store value and broadcast to listeners
  saveSensorValue = (value) ->
    if sensor? and value?
      measurement = new Measurement()
      measurement.create({value}).then((id) ->
        sensor.addDependency('measurements', id).then(->
          new Measurement(id).getObject().bind(@).then((object) ->
            socket.emit('sensor:' + sensor.id + ':measurements:added', object)
          )
        )
      )

  # Read first time
  readSensorValue(saveSensorValue)

  # Run forever
  readForever = ->
    readInterval = 1000 * 60 * 60 # Read every hour
    setTimeout(->
      readSensorValue(saveSensorValue)
      readForever()
    , readInterval)

  # Run
  readForever()
