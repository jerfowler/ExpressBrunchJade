module.exports = exports = (control) ->
    (socket) ->
        control.emit '/brunch/connection', socket
        control.on '/brunch/reload', (delay) ->
            socket.emit 'reload', delay