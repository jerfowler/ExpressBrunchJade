exists = (require 'fs').exists or (require 'path').exists
{basename} = require 'path'
chokidar = require 'chokidar'
Walker = require './walker'
async = require 'async'

ignored = (reg) ->
    (path) ->
        reg.test basename path

module.exports = (watched, ignore, callback) ->
    async.filter watched, exists, (files) ->
        walker = new Walker files, ignore: ignore
        walker.on 'end', (snapshot) ->
            watcher = chokidar.watch files, ignored: ignored(ignore), persistent: true
            callback watcher, snapshot