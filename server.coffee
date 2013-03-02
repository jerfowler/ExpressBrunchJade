debug = require('debug')('brunch:server')
logger = require './lib/logger'
{config} = require './config'
{resolve} = require 'path'
initWatcher = require './lib/watcher'
http = require 'http'
app = require './express'

sockets = null
io = null

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
    io = require('socket.io').listen server, logger: logger
    io.set 'log level', 1
    sockets = require('./express/sockets')(io)
    server.listen port, callback

reload = (snapshot) ->
    debug 'Reloading...'
    sockets.emit '/brunch/reload', 1000
    sockets.destroy()
    resetCache snapshot
    app = require './express'
    sockets = require('./express/sockets')(io)

module.exports.startServer = (port, path, callback) ->
    server = start(port, callback)
    if config?.server?.watched?
        watched = config.server.watched
        ignored = config.server.ignored
        initWatcher watched, ignored, (watcher, snapshot) ->
            # Wait till after Brunch initializes before watching files...
            setTimeout ->
                watcher
                .on 'add', (path) ->
                    unless path in snapshot
                        reload snapshot
                        snapshot.push path
                .on 'change', (path) ->
                    reload snapshot
                .on 'unlink', (path) ->
                    reload snapshot
                    idx = snapshot.indexOf path
                    snapshot.splice idx, 1 if idx isnt -1
            , 1000
    server