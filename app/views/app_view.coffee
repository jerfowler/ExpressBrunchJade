View = require 'lib/view'

module.exports = AppView = View.extend(
    el: '#AppView'

    name: 'AppView'

    debug: off

    autoRender: on

    template: require 'views/templates/app_view'

    bootstrap: ->
        console.log 'Bootstrap: AppView initialized...'
)

# *** Note, lib/view doesn't execute bootstrap anymore... ***
# *** You now have to override initialize and add it      ***
AppView::initialize = ->
    super
    @bootstrap()

# Alternatively, you could listen for the initialize 
# or initialize:before events and put your logic there
AppView::initialize = ->
    @on 'initialize', ->
        console.log 'Event: AppView initialized...'
    super

# ...or just quit being a jerk and keep it simple stupid (KISS)!
# Anything you add to bootstrap, just override and add to initialize
AppView::initialize = ->
    super
    console.log 'AppView initialized...'
