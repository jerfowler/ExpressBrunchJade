{EventEmitter} = require 'events'
{basename, join} = require 'path'
{stat, readdir} = require 'fs'
{isArray} = require 'util'

class Walker extends EventEmitter
    constructor: (paths, options) ->
        @walk(paths, options) if paths

    walk: (paths, options={}) ->
        @_options = options
        #ignore nothing by default
        @_options.ignore ?= /a^/
        #match everything by default
        @_options.match ?= /.*/
        @_files = []
        @_paths = {}
        paths = [paths] if not isArray paths
        @_stat path for path in paths
        @

    _stat: (path) ->
        @_paths[path] = path
        stat path, (err, stats) =>
            return @_error path, err if err
            return @_dir path if stats.isDirectory()
            return @_file path if stats.isFile()
            @_other path, stats
            
    _dir: (path) ->
        readdir path, (err, list) =>
            return @_error path, err if err
            @_stat join path, file for file in list
            delete @_paths[path]
            @emit 'end', @_files if Object.keys(@_paths).length is 0

    _file: (path) ->
        unless @_options.ignore.test basename path
            if @_options.match.test basename path
                @_files.push path
                @emit 'file', path
        delete @_paths[path]
        @emit 'end', @_files if Object.keys(@_paths).length is 0

    _other: (path, stats) ->
        @emit 'other', path, stats
        delete @_paths[path]
        @emit 'end', @_files if Object.keys(@_paths).length is 0

    _error: (path, err) ->
        @emit 'error', path, err
        delete @_paths[path]
        @emit 'end', @_files if Object.keys(@_paths).length is 0

module.exports = exports = Walker