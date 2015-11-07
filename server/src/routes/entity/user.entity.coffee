module.exports =
  class User extends require('default.entity')

    getEntityIdentifier: ->
      'user'

    getDependencyIdentifiers: ->
      workspaces: require('entity/workspace.entity')
      organizations: require('entity/organization.entity')