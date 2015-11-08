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

      if @lastMeasurement  > 2500
        @color =  'red'
      else if @lastMeasurement < 2500 and @lastMeasurement > 500
        @color =   'orange'
      else
        @color =   'green'

    getIdentifier: ->
      'sensor'

    getLastMeasurement: ->
      return @lastMeasurement

    added: (object, key) ->
      if key is 'measurements'
        @lastMeasurement = @objects.measurements[@objects.measurements.length - 1].values.value
        @measurementValues.push(parseInt(object.values.value))
        @measurementIntervals.push(object.id)

        if @lastMeasurement  > 2500
          @color =  'red'
        else if @lastMeasurement < 2500 and @lastMeasurement > 500
          @color =   'orange'
        else
          @color =   'green'



    getMeasurementValues: ->
      (parseInt(measurement.values.value) for measurement in @objects.measurements)

    getMeasurementIntervals: ->
      (measurement.id for measurement in @objects.measurements)

    getMeasurement: (id) ->
      @lookup('measurements', id)
)