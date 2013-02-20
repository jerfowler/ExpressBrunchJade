express = require 'express'
{join} = (require 'path')
{config} = (require './config')
routes = require './routes'
http = require 'http'

app = express()

app.configure ->
    app.set 'views', join __dirname, 'views'
    app.set 'view engine', config.view.engine
    app.use express.favicon()
    app.use express.logger 'dev'
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser(config.cookie.secret)
    app.use express.session()
    app.use app.router
    app.use express.static join __dirname, '..', 'public'

app.configure 'development', ->
    app.use express.errorHandler()
    app.locals.pretty = true

app.get '/', routes.index('Express', express.version)
app.get '/test', routes.test('Mocha Tests')

### Default 404 middleware ###
app.use routes.error('Page not found :(', 404)

module.exports = exports =  http.createServer(app)