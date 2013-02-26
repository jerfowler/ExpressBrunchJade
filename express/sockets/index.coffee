{EventEmitter} = require 'events'

control = null

sockets =
    '/app': require './app'
    '/brunch': require './brunch'

class SocketControl extends EventEmitter
    io: null
    constructor: (io) ->
        @io = io
        @ns = []
        for ns, init of sockets
            @ns.push ns
            @io.of(ns).on 'connection', init(@)
    destroy: ->
        for ns in @ns
            @emit ns+'/destroy'
            delete @io.namespaces[ns]
        @removeAllListeners()

module.exports = exports = (io) ->
    control = if control then control else new SocketControl(io)