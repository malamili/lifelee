Promise = require('bluebird')

module.exports =
  class User extends require('default.entity')

    getEntityIdentifier: ->
      'token'

    getDependencyIdentifiers: ->
      session: require('entity/session.entity')

    create: (token) ->
      @id = token

      Promise.all([
        @addToCollection()
      ]).then(->
        @id
      )