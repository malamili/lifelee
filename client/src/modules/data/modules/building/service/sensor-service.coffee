'use strict'

angular.module 'weaver.data.building'

.factory('Sensor', (ServerObject, Measurement) ->

  class Sensor extends ServerObject

    constructor: (sensor) ->
      super(sensor)
      @load('measurements', Measurement)

      if @objects.measurements.length isnt 0
        @lastMeasurement = @objects.measurements[@objects.measurements.length - 1].values.value
      else
        @lastMeasurement = 0

      # Needed for the chart
      @measurementValues    = (parseInt(measurement.values.value) for measurement in @objects.measurements)
      @measurementIntervals = (measurement.id for measurement in @objects.measurements)

    getIdentifier: ->
      'sensor'

    getLastMeasurement: ->
      return @lastMeasurement

    added: (object, key) ->
      if key is 'measurements'
        @measurementValues.push(parseInt(object.values.value))
        @measurementIntervals.push(object.id)

    getMeasurementValues: ->
      (parseInt(measurement.values.value) for measurement in @objects.measurements)

    getMeasurementIntervals: ->
      (measurement.id for measurement in @objects.measurements)

    getMeasurement: (id) ->
      @lookup('measurements', id)
)