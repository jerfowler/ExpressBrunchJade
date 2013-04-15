BrunchServer = require './lib/server'
{config} = require './config'

module.exports.startServer = (port, path, callback) ->
    bsvr = new BrunchServer(config)
    io = require('socket.io').listen bsvr.server, logger: bsvr.logger
    io.set 'log level', 2 
    sockets = require('./express/sockets')(io)

    bsvr.on 'reload', ->
        sockets.emit '/brunch/reload', 1000
        sockets.destroy()
        sockets = require('./express/sockets')(io)

    bsvr.start(port, callback)
    bsvr