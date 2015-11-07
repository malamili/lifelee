# This is the main entry point of any new component
module.exports =
  control: (app) ->
    require('index/index').serve(app)        # Index page
    require('http/cors').allow(app)          # CORS