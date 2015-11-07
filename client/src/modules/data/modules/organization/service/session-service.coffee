'use strict'

angular.module 'weaver.data.organization'

.factory('Session', (ServerObject) ->

  class Session extends ServerObject

    constructor: (session) ->
      super(session)

    getIdentifier: ->
      'session'
)