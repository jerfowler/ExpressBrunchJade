module.exports = exports = 
    '/app': (socket) ->
        socket.on 'initialize', ->
            socket.emit 'msg', 'Welcome to Express Brunch with Jade...'