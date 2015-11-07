url = require('url')

module.exports =

  serve: (app) ->
    if require('config').get('server.index')
      app.get('/', (req, res) ->
          res.sendFile('index.html', root: __dirname)
      )