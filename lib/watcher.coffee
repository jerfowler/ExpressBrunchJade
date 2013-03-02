exists = (require 'fs').exists or (require 'path').exists
debug = require('debug')('brunch:server')
Walker = require './walker'
linter = require './linter'
tester = require './tester'
{watch} = require 'chokidar'
{basename} = require 'path'
{filter} = require 'async'

getIgnored = (reg) ->
    (path) ->
        reg.test basename path

setDebug = (watcher, snapshot) ->
    watcher
    .on 'add', (path) ->
        debug 'New file detected: '+path unless path in snapshot
    .on 'change', (path) ->
        debug 'File changed: '+path
    .on 'unlink', (path) ->
        debug 'File deleted: '+path

module.exports = exports = (watched, ignored, callback) ->
    filter watched, exists, (files) ->
        walker = new Walker files, ignore: ignored
        walker.on 'end', (snapshot) ->
            watcher = watch files, {
                ignored: getIgnored(ignored)
                persistent: true
            }
            setDebug watcher, snapshot
            linter watcher, snapshot, 1000
            tester watcher, snapshot, 2000
            callback watcher, snapshot
            