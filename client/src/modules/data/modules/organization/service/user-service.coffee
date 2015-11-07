'use strict'

angular.module 'weaver.data.organization'

.factory('User', (ServerObject, Workspace, Organization) ->

  class User extends ServerObject

    constructor: (user) ->
      super(user)
      @load('workspaces', Workspace)
      @load('organizations', Organization)

    getIdentifier: ->
      'user'

    getBoolTypes: ->
      ['datasetTableOn', 'datasetSchemaOn', 'datasetModelListOn']

    getIntTypes: ->
      ['activeModel']

    getWorkspace: (id) ->
      @lookup('workspaces', id)

    # Get finger print when loaded because it takes some time and we will need it in the future
    # We use a $timeout of 0 to execute in the next digest cycle, letting the page first fully render.
    #$timeout(User.readFingerprint, 0)
)