module.exports =
  class Workspace extends require('default.entity')

    getEntityIdentifier: ->
      'workspace'

    getDependencyIdentifiers: ->
      buildings: require('entity/building.entity')