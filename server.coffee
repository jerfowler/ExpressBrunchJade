debug = require('debug')('brunch:server')
{config} = require './config'
{resolve} = require 'path'
initWatcher = require './lib/watcher'
http = require 'http'

app = require './express'
sockets = require './express/sockets'
server = null
io = null
clients = {}

# Hot code push
resetCache = (snapshot) ->
    for path in snapshot
        path = resolve path
        for key of require.cache
            if key is path
                delete require.cache[key] 
                break 

listener = (req, res) ->
    app(req, res)

start = (port, callback) ->
    server = http.createServer listener
    io = require('socket.io').listen server
    io.set 'log level', 1
    io.of('/brunch')
        .on 'connection', (client) =>
            clients[client.id] = client
            client.on 'disconnect', ->
                delete clients[client.id]
    for ns,connect of sockets
        io.of(ns).on 'connection', connect
    server.listen port, callback    

reload = (snapshot) ->
    console.log 'Reloading..'
    resetCache snapshot
    app = require './express'
    sockets = require './express/sockets'
    for ns, connect of sockets
        delete io.namespaces[ns]
        io.of(ns).on 'connection', connect
    clients[id].emit 'reload', 1000 for id of clients
    clients = {}

module.exports.startServer = (port, path, callback) ->
    start(port, callback)
    if config?.server?.watched?
        watched = config.server.watched
        ignored = config.server.ignored
        initWatcher watched, ignored, (watcher, snapshot) ->
            # Wait till after Brunch initializes before watching files...
            setTimeout ->
                watcher
                    .on 'add', (path) ->
                        unless path in snapshot
                            debug 'New file detected: '+path
                            reload snapshot
                            snapshot.push path
                    .on 'change', (path) ->
                        debug 'File changed: '+path
                        reload snapshot
                    .on 'unlink', (path) ->
                        debug 'File deleted: '+path
                        reload snapshot
                        idx = snapshot.indexOf path
                        snapshot.splice idx, 1 if idx isnt -1
            , 1000
    server