'use strict'

angular.module 'weaver.data.organization'

.factory('Organization', (ServerObject) ->

  class Organization extends ServerObject

    constructor: (organization) ->
      super(organization)

    getIdentifier: ->
      'organization'
)