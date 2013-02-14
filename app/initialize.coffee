# App Namespace
# Change `App` to your app's name
@App ?= _.extend {}, Backbone.Events
App.Routers ?= {}
App.Views ?= {}
App.Models ?= {}
App.Collections ?= {}

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