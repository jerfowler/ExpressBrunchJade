debug = require('debug')('brunch:server:linter')
logger = require './logger'
{config} = require '../config'
coffeelint = require 'coffeelint'
{resolve} = require 'path'
fs = require 'fs'

source = config?.server?.source or /.*\.coffee$/
config = config?.server?.coffeelint or {}
pattern = config.pattern or /^.*_test\.coffee$/
options = config.options or {}

lintError = (err, file) ->
    logger.error "#{file}[#{err.lineNumber}] - #{err.message}
     #{if err.context? then ', '+err.context else ''}"

read = (path) ->
    path = resolve path
    fs.readFileSync(path).toString()

lint = (file) ->
    debug "Linting #{file}..."
    try
        errors = coffeelint.lint read(file), options
        lintError error, file for error in errors
    catch err
        logger.error "Coffeelint: (#{file}) - #{err.message}"

module.exports = exports = (watcher, snapshot, delay) ->
    return if config.enabled is off
    logger.info 'Linting server files...'
    setTimeout ->
        files = snapshot.filter (file) -> source.test file
        lint file for file in files
        watcher
        .on 'add', (path) ->
            return if path in snapshot
            lint path if source.test path

        .on 'change', (path) ->
            lint path if source.test path
    , delay