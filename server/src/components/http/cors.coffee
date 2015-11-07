module.exports =

  allow: (app) ->
    if require('config').get('server.cors')  
      app.all('*', (req, res, next) ->
        res.header('Access-Control-Allow-Origin', '*');
        res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
        res.header('Access-Control-Allow-Headers', 'Content-Type');
        next()
      )