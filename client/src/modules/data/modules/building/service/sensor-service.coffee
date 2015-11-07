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

    getIdentifier: ->
      'sensor'

    getLastMeasurement: ->
      return @lastMeasurement

    getMeasurement: (id) ->
      @lookup('measurements', id)
)