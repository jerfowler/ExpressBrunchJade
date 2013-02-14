# App Namespace
# Change `App` to your app's name
@App ?= {}
App.Routers ?= {}
App.Views ?= {}
App.Models ?= {}
App.Collections ?= {}

$ ->
	
    # Initialize App
    App.Views.AppView = new AppView = require 'views/app_view'

    # Initialize Router
    App.Routers.AppRouter = new AppRouter = require 'routers/app_router'

    # Initialize Backbone History
    Backbone.history.start pushState: yes
