debug = require('debug')('brunch:server:tester')
{config} = require '../config'
logger = require './logger'
Mocha = require 'mocha'

source = config?.server?.source or /.*\.coffee$/
config = config?.server?.mocha or {}
pattern = config.pattern or /^.*_test\.coffee$/
options = config.options or reporter:'spec'

tests = []

run = (files) ->
    mocha = new Mocha(options)
    mocha.addFile file for file in files
    mocha.run()

module.exports = exports = (watcher, snapshot, delay) ->
    return if config.enabled is off
    logger.info 'Running server tests...'
    setTimeout ->
        tests = snapshot.filter (file) -> pattern.test file
        run tests
        watcher
        .on 'add', (path) ->
            return if path in snapshot
            if pattern.test path
                unless path in tests
                    debug "Add: #{path} is a test file"
                    tests.push path
                    run [path]
            else
                run tests if source.test path

        .on 'change', (path) ->
            if pattern.test path
                debug "Change: #{path} is a test file"
                run [path]
            else if source.test path
                run tests

        .on 'unlink', (path) ->
            if pattern.test path
                debug "Unlink: #{path} is a test file"
                tests.splice idx, 1 if (idx = tests.indexOf path) isnt -1
    , delay