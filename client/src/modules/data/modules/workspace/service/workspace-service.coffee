'use strict'

# Project data model
angular.module 'weaver.data.workspace'

.factory('Workspace', (ServerObject, Building) ->

  class Workspace extends ServerObject

    constructor: (workspace) ->
      super(workspace)
      @load('buildings', Building)

    getIdentifier: ->
      'workspace'

    getBuilding: (id) ->
      @lookup('buildings', id)
)