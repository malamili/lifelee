'use strict'

angular.module 'weaver.auth'

.factory('Auth', ($localForage, $$Promise, Socket, Session, User) ->

  class Auth
    constructor: (@session, @user) ->

    @init: ->
      auth = new Auth()
      auth.signin().then(-> auth)

    signup: ->
      Socket.emit('auth:signup').bind(@).then((response) ->
        @setToken(response.token)
        @session = new Session(response.session)
        @user = new User(response.user)
      )

    signin: ->
      @getToken().bind(@).then((token) ->
        if token
          Socket.emit('auth:signin', token).bind(@).then((response) ->
            if response.granted
              @session = new Session(response.session)
              @user = new User(response.user)
          )
      )

    signout: ->
      @user = undefined
      @session = undefined
      @deleteToken()

    setToken: (token) ->
      $localForage.setItem('user.token', token)

    getToken: ->
      deferred = $$Promise.defer()

      $localForage.getItem('user.token').then((token) ->
        deferred.resolve(token)
      )

      deferred.promise

    deleteToken: ->
      $localForage.removeItem('user.token')
)