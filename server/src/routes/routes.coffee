Router = require('router')

# This is the main entry point of any new socket connection.
# Every message signature is in the form of:
# model:CRUD:(optional keyword)
module.exports =
  wire: (socket) ->

    route = Router(socket)

    # Auth
    route 'auth','signup'
    route 'auth','signin'

    # Organization
    route 'organization','create'
    route 'organization','update'
    route 'organization','delete'
    route 'organization','add'
    route 'organization','remove'

    # User
    route 'user','create'
    route 'user','update'
    route 'user','delete'
    route 'user','add'
    route 'user','remove'

    # Session
    route 'session','create'
    route 'session','update'
    route 'session','delete'

    # Workspace
    route 'workspace','create'
    route 'workspace','update'
    route 'workspace','delete'
    route 'workspace','add'
    route 'workspace','remove'

    # Building
    route 'building','create'
    route 'building','update'
    route 'building','delete'
    route 'building','add'
    route 'building','remove'

    # Space
    route 'space','create'
    route 'space','update'
    route 'space','delete'
    route 'space','add'
    route 'space','remove'

    # Sensor
    route 'sensor','create'
    route 'sensor','read'
    route 'sensor','update'
    route 'sensor','delete'
    route 'sensor','add'
    route 'sensor','remove'

    # Measurement
    route 'measurement','create'
    route 'measurement','read'
    route 'measurement','delete'
    route 'measurement','update'