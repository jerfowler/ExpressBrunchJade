View      = require 'lib/view'
AppRouter = require 'routers/app_router'

module.exports = AppView = View.extend(
    el: 'body.application'

    initialize: ->
        @router = new AppRouter()
        App?.Routers?.AppRouter = @router
)