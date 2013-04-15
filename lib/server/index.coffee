exists = (require 'fs').exists or (require 'path').exists
{EventEmitter} = require 'events'
{resolve, join} = require 'path'
{filter} = require 'async'
http = require 'http'
cordell = require 'cordell'
logger = require '../logger'

class BrunchServer extends EventEmitter
    constructor: (config) ->
        @config = {}
        @config[name] = value for name, value of config.server
        throw 'Must specify an app location under config.server.app' unless @config.app?
        @app = require join process.cwd(), @config.app
        @server = http.createServer @_listener
        # Expose the brunch logger
        @logger = logger
        @_debug = if @config.debug? require('debug')("#{@config.debug}") else ->

    _listener: (req, res) =>
        @app(req, res)

    start: (port, callback) ->
        @server.listen port, callback
        if @config?.watched?
            filter @config.watched, exists, (files) =>
                @ranger = cordell.ranger files, @config, @logger
                @ranger.on 'end', (files, stats) =>
                    setTimeout =>
                        @ranger.on 'add', =>
                            @reload()
                        @ranger.on 'rem', =>
                            @reload()
                        @ranger.on 'change', =>
                            @reload()
                    , 1000
        @emit 'start', @

    stop: (fn) ->
        @_debug 'Stopping...'
        @server.close fn
        @watcher.close()
        @emit 'stop', @

    reload: ->
        @_debug 'Reloading...'
        @app = require join process. cwd(), @config.app
        @emit 'reload', @

    close: (fn) ->
        @stop fn

module.exports = exports = BrunchServer