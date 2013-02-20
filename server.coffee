config = (require './config').config
resolve = (require 'path').resolve
initWatcher = require './lib/watcher'

server = null

# Hot code push
resetCache = (snapshot) ->
    for path in snapshot
        path = resolve path
        for key of require.cache
            if key is path
                delete require.cache[key]
        for item,key in module.children
            if item.id is path
                module.children.splice(key,1) 
                break        

restart = (port, callback, snapshot) ->
    server.close ->
    resetCache snapshot
    server = require './express'
    server.on 'connection', (socket) ->
        socket.setTimeout 10*1000
    server.on 'error', (e) ->
        if e.code is 'EADDRINUSE'
            console.log 'Address in use, retrying...'
            setTimeout ->
                server.close()
                server.listen port, callback
            , 1000
    server.listen port, callback

module.exports.startServer = (port, path, callback) ->
    server = require './express'
    server.listen port, callback
    server.on 'connection', (socket) ->
        socket.setTimeout 10*1000

    if config?.server?.watched?
        watched = config.server.watched
        ignored = config.server.ignored
        initWatcher watched, ignored, (watcher, snapshot) ->
            watcher
                .on 'add', (path) ->
                    unless path in snapshot
                        restart port, callback, snapshot
                        snapshot.push path
                .on 'change', (path) ->
                    restart port, callback, snapshot
                .on 'unlink', (path) ->
                    restart port, callback, snapshot
                    idx = snapshot.indexOf path
                    snapshot.splice idx, 1 if idx isnt -1
    server