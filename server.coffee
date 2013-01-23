
exports.startServer = (port, path, callback) ->
  express = require 'express'
  routes = require './express/routes'
  path = require 'path'
  http = require 'http'
  app = express()

  app.configure ->
    app.set 'views', path.join __dirname, 'express', 'views'
    app.set 'view engine', 'jade'
    app.use express.favicon()
    app.use express.logger 'dev'
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser('Express Brunch Rules!')
    app.use express.session()
    app.use app.router
    app.use express.static path.join __dirname, 'public'

  app.configure 'development', ->
    app.use express.errorHandler()
    app.locals.pretty = true

  app.get '/', routes.index('Express', express.version)
  app.get '/test', routes.test('Mocha Tests')

  ### Default 404 middleware ###
  app.use routes.error('Page not found :(', 404)

  http.createServer(app)
    .listen(port, ->
      console.log "Express server listening on port " + port
      callback()
    )