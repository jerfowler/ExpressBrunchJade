config = (require './config').config
initWatcher = require './lib/watcher'
http = require 'http'

server = null

restart =  (port, callback) ->
    return unless server?.close?
    server.close ->
        express = require './express'
        server = http.createServer(express).listen(port, callback)

exports.startServer = (port, path, callback) ->
    express = require './express'
    server = http.createServer(express).listen(port, callback)
    server.on 'close', ->
        server = null

    if config?.server?.watched?
        watched = config.server.watched
        ignored = config.server.ignored
        initWatcher watched, ignored, (watcher, snapshot) ->
            watcher
                .on 'add', (path) ->
                    restart port, callback unless path in snapshot
                .on 'change', (path) ->
                    restart port, callback
                .on 'unlink', (path) ->
                    restart port, callback 

    server