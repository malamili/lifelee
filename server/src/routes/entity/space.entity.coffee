module.exports =
  class Space extends require('default.entity')

    getEntityIdentifier: ->
      'space'

    getDependencyIdentifiers: ->
      sensors: require('entity/sensor.entity')
