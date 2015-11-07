'use strict'

angular.module 'weaver.data.building'

.factory('Building', (ServerObject, Space) ->

  class Building extends ServerObject

    constructor: (building) ->
      super(building)
      @load('spaces', Space)

    getIdentifier: ->
      'building'

    getSpace: (id) ->
      @lookup('spaces', id)
)