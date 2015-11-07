module.exports =
  class Sensor extends require('default.entity')

    getEntityIdentifier: ->
      'sensor'

    getDependencyIdentifiers: ->
      measurements: require('entity/measurement.entity')
