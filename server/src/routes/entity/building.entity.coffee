module.exports =
  class Building extends require('default.entity')

    getEntityIdentifier: ->
      'building'

    getDependencyIdentifiers: ->
      spaces: require('entity/space.entity')
