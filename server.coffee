{config} = require './config'
{resolve} = require 'path'
initWatcher = require './lib/watcher'
{inspect} = require 'util'
http = require 'http'
debug = require('debug')('brunch:server')

server = null
sockets = []

# Hot code push
resetCache = (snapshot) ->
    for path in snapshot
        path = resolve path
        for key of require.cache
            if key is path
                delete require.cache[key] 
                break 

start = (port, callback) ->
    server = http.createServer (req, res) ->
        app = require './express'            
        app(req, res)
    io = require('socket.io').listen server
    io.set('log level', 1);
    io.of('/brunch')
        .on 'connection', (socket) =>
            sockets.push socket
    server.listen port, callback    

reload = (port, callback, snapshot) ->
    socket.emit 'reload', 1000 for socket in sockets
    sockets = []
    resetCache snapshot

module.exports.startServer = (port, path, callback) ->
    start(port, callback)
    if config?.server?.watched?
        watched = config.server.watched
        ignored = config.server.ignored
        initWatcher watched, ignored, (watcher, snapshot) ->
            watcher
                .on 'add', (path) ->
                    unless path in snapshot
                        debug 'New file detected: '+path
                        reload port, callback, snapshot
                        snapshot.push path
                .on 'change', (path) ->
                    debug 'File changed: '+path
                    reload port, callback, snapshot
                .on 'unlink', (path) ->
                    debug 'File deleted: '+path
                    reload port, callback, snapshot
                    idx = snapshot.indexOf path
                    snapshot.splice idx, 1 if idx isnt -1
    server