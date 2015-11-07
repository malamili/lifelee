# Path resolving for the routes and components folder, making it non-relative accessible from any location.
# In other words, require('../../../../logger/logger') translates to require('logger/logger')
require('app-module-path').addPath('./routes')
require('app-module-path').addPath('./components')

# Server Dependencies: Express, Node default http and Socket.io
app       = require('express')()
http      = require('http').Server(app)
io        = require('socket.io')(http)

# Components used for config and color printing
config    = require('config')                         # Configuration loads files in ./config directory
colors    = require('colors')                         # Usage: "hello".green or 'world'.red to change colors

# Initialize components that function on the app object (CORS, Static serving, etc)
require('components').control(app)

# Listen for Socket.IO connections
io.on('connection', (socket) ->

  # Wire socket routes
  require('routes').wire(socket)
)

# Launch!
version = config.get('weaver.version')
port = config.get('server.port')
server = http.listen(port, ->

  top      = '┌──────────────────────────────────────┐' .cyan
  title    = '│ Lifelee: '                              .cyan
  endTitle  =                '                       │' .cyan
  ready    = '│ Ready to serve clients on port: '       .cyan
  endReady =                                       ' │' .cyan
  bottom   = '└──────────────────────────────────────┘' .cyan

  console.log(top)
  console.log(title + version.magenta + endTitle)
  console.log(ready + (port + '').magenta + endReady)
  console.log(bottom)
)