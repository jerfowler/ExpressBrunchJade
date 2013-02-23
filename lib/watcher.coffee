exists = (require 'fs').exists or (require 'path').exists
Walker = require './walker'
{watch} = require 'chokidar'
{basename} = require 'path'
{filter} = require 'async'

getIgnored = (reg) ->
    (path) ->
        reg.test basename path

module.exports = exports = (watched, ignored, callback) ->
    filter watched, exists, (files) ->
        walker = new Walker files, ignore: ignored
        walker.on 'end', (snapshot) ->
            watcher = watch files, ignored: getIgnored(ignored), persistent: true
            callback watcher, snapshot