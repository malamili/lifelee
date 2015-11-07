'use strict'

angular.module 'weaver.data.building'

.factory('Space', (ServerObject, Sensor) ->

  class Space extends ServerObject

    constructor: (space) ->
      super(space)
      @load('sensors', Sensor)

    getIdentifier: ->
      'space'

    getSensor: (id) ->
      @lookup('sensors', id)
)