'use strict'

angular.module 'weaver.data.building'

# Either CO2 or Occupancy
.factory('Measurement', (ServerObject) ->

  class Measurement extends ServerObject

    constructor: (measurement) ->
      super(measurement)

    getIdentifier: ->
      'measurement'
)