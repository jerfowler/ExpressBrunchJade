# App Namespace
App =
    Routers: {}
    Views: {}
    Models: {}
    Collections: {}
    Sockets: {}

module.exports = _.extend App, Backbone.Events

$ ->
	
    # App is an Event Emmiter / mediator
    App.on 'initialize', (msg) ->
        console.log msg

    # Initialize App
    App.Views.AppView = new AppView = require 'views/app_view'

    # Initialize Router
    App.Routers.AppRouter = new AppRouter = require 'routers/app_router'

    # Initialize Backbone History
    Backbone.history.start pushState: yes

    # trigger the initialize event for the app
    App.trigger 'initialize', 'Backbone App initialized...', App

    if io
        App.Sockets.AppSocket = io.connect '/app'
        App.Sockets.AppSocket.on 'msg', (msg) ->
            console.log 'Socket.io Msg: '+msg
        App.Sockets.AppSocket.emit 'initialize'