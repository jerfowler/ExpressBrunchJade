{EventEmitter} = require 'events'
{basename} = require 'path'
{join} = require 'path'
util = require 'util'
fs = require 'fs'

class Walker extends EventEmitter
    constructor: (paths, options) ->
        @walk(paths, options) if paths

    walk: (paths, options={}) ->
        @_options = options
        @_options.ignore ?= /a^/
        @_files = []
        @_paths = {}
        if util.isArray(paths)
            paths.forEach (path) =>
                @_stat path
        else
            @_stat paths
        @

    _stat: (path) ->
        @_paths[path] = path
        fs.stat path, (err, stats) =>
            @emit 'error', err if err
            @_dir(path) if stats.isDirectory()
            @_file(path) if stats.isFile()

    _dir: (path) ->
        fs.readdir path, (err, list) =>
            @emit 'error', err if err
            list.forEach (file) =>
                @_stat join path, file
            delete @_paths[path]
            @emit 'end', @_files if Object.keys(@_paths).length is 0

    _file: (file) ->
        unless @_options.ignore.test basename file
            @_files.push file
            @emit 'file', file
        delete @_paths[file]
        @emit 'end', @_files if Object.keys(@_paths).length is 0

module.exports = Walker