'use strict'

angular.module 'weaver.data'

# Base class for all server objects
.factory('ServerObject', ($rootScope, Socket, $$Promise) ->

  class ServerObject
    constructor: (object) ->
      @idDeferred = $$Promise.pending()
      @changeListeners = []
      if(object.id?)
        @id = parseInt(object.id)


      @queue = []
      @dependencies = []

      @values = {}

      # Copy keys for values
      for key, value of object when key isnt 'id'
        if key in @getIntTypes()
          @values[key] = parseInt(value)
        else if key in @getBoolTypes()
          @values[key] = value is "true"
        else
          @values[key] = value


      # Listen for server and client events
      @getId().bind(@).then(@listen)

      $rootScope.$broadcast(@getIdentifier()+':created', @)

    # Objects identifier server side, such as 'project' or 'attribute'
    getIdentifier: ->
      console.log('Error: Identifier not set')
      undefined

    getIntTypes: ->
      []

    getBoolTypes: ->
      []

    # Emit serves two purposes:
    # 1. It will inject the id of this object into the payload
    # 2. It will hold all messages in a queue until server id is received
    emit: (tag, payload) ->
      # Add empty payload if none
      payload = if payload? then payload else {}

      @queue.push({tag, payload})

      if @id?
        @flush()

    flush: ->
      for message in @queue
        message.payload.id = @id    # Append id that is not available
        Socket.emit(message.tag, message.payload)

      @queue = []


    lookup: (identifier, id) ->
      objects = @objects[identifier]
      idPromises = (object.getId() for object in objects)

      $$Promise.all(idPromises).then( ->
        map = {}
        for object, index in objects
          map[object.id] = index

        objects[map[id]]
      )

    read: ->
      Socket.emit(@getIdentifier()+ ':read', {@id})

    load: (key, Type) ->
      @objects = {} if not @objects?
      @dependencies.push(key)

      if @values[key]?
        @objects[key] = (new Type(object) for object in @values[key])
        delete @values[key]
      else
        @objects[key] = []

      self = @
      listenAdd = ->
        Socket.on(self.getIdentifier()+ ':' + self.id + ':' +key+ ':added').then((object) ->
          self.objects[key].push(new Type(object))
          self.added(new Type(object), key)
          listenAdd()
        )

      listenRemove = ->
        Socket.on(self.getIdentifier()+ ':' + self.id + ':' +key+ ':removed').then((objectId) ->
          self.lookup(key, objectId).then((object) ->
            self.objects[key].splice(self.objects[key].indexOf(object), 1)
          )
          listenRemove()
        )

      @getId().then(->
        listenAdd()
        listenRemove()
      )

    # TODO: Support lazy loading
    promise: (key) ->
      $$Promise.resolve(@objects[key])

    getId: ->
      if @id? then $$Promise.resolve(@id) else @idDeferred.promise

    onChange: (listener) ->
      @changeListeners.push(listener)

    setId: (id) ->
      @idDeferred.resolve(parseInt(id)) if not @id?
      @id = parseInt(id)
      @flush()


    set: (attribute, value) ->
      @values[attribute] = value
      @update(attribute)

    link: (key, object) ->
      object.getId().bind(@).then((objectId) ->
        @set(key, objectId)
      )

    add: (object, key) ->
      @objects[key].push(object)

      object.getId().bind(@).then((objectId) ->
        @emit(@getIdentifier()+ ':add', {key, objectId})
      )

    # Handle for subtype to act on event
    added: (object, key) ->
      return

    remove: (object, key) ->
      @objects[key].splice(@objects[key].indexOf(object), 1)

      object.getId().bind(@).then((objectId) ->
        @emit(@getIdentifier()+ ':remove', {key, objectId})
      )

    create: ->
      payload = {}
      payload[key] = value for key, value of @values
      Socket.emit(@getIdentifier()+ ':create', payload).bind(@).then(@setId)

    update: (attribute, value) ->
      listener.call() for listener in @changeListeners
      @emit(@getIdentifier()+ ':update', {attribute, value: @values[attribute]})

    delete: ->
      @emit(@getIdentifier()+ ':delete')

    listen: ->
      @listenDelete()
      @listenUpdate()

    listenDelete: ->
      Socket.on(@getIdentifier()+ ':deleted:' +@id).bind(@).then(->
        $rootScope.$broadcast(@getIdentifier()+ ':deleted', @)
      )

    listenUpdate: ->
      Socket.on(@getIdentifier()+ ':updated:'+@id).bind(@).then((change) ->
        @values[change.attribute] = change.value
        @listenUpdate()
      )
)