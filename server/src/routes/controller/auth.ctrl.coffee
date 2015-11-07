Promise     = require('bluebird')
randomBytes = Promise.promisify(require('crypto').randomBytes)

Token = require('entity/token.entity')
User = require('entity/user.entity')
Session = require('entity/session.entity')

module.exports =

  class AuthCtrl
    signup: (payload, socket, ack) ->

      randomBytes(48).then((buf) ->
        tokenId = buf.toString('hex')

        token = new Token()
        token.create(tokenId)

        session = new Session()
        session.create().then(->
          token.update('session', session.getId())
          session.update('token', tokenId)

          user = new User()
          user.create({lastPath: 'workspace'}).then(->
            session.update('user', user.getId())
            user.addDependency('sessions', session.getId())
          )

          session.getObject().then((sessionObject) ->
            user.getObject().then((userObject) ->
              ack({token: tokenId, session: sessionObject, user: userObject})
            )
          )
        )
      )


    signin: (tokenId, socket, ack) ->
      new Token(tokenId).read("session").then((sessionId)->
        session = new Session(sessionId)
        session.read("user").then((userId) ->
          user = new User(userId)

          session.getObject().then((sessionObject) ->
            user.getObject().then((userObject) ->
              ack(granted: true, user: userObject, session: sessionObject)
            )
          )
        )
      )


