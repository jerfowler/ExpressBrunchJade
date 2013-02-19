View = require 'lib/view'

module.exports = AppView = View.extend(
    el: '#AppView'

    name: 'AppView'

    debug: off

    autoRender: on

    template: require 'views/templates/app_view'

    bootstrap: ->
        console.log "#{@name} bootstrap..."
)

# *** Note, lib/view doesn't execute bootstrap anymore ***
# *** You now have to override initialize and add it   ***
AppView::initialize = ->
    @bootstrap()
    super

# Alternatively, you could listen for the initialize
# or initialize:before events and put your logic there
AppView::on 'initialize', ->
    console.log "#{@name} initialized..."