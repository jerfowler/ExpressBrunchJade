module.exports = exports = (control) ->
    (socket) ->
        control.emit '/app/connection', socket
        socket.on 'initialize', ->
            control.emit '/app/initialize', socket
            socket.emit 'msg', 'Welcome to Express Brunch with Jade...'