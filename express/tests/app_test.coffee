request = require 'supertest'
app = require '..'

describe 'GET /', () ->
    it 'respond with 200', (done) ->
        request(app)
            .get('/')
            .expect(200, done)

describe 'GET /test', () ->
    it 'respond with 200', (done) ->
        request(app)
            .get('/test')
            .expect(200, done)

describe 'GET /error', () ->
    it 'respond with 404', (done) ->
        request(app)
            .get('/error')
            .expect(404, done)
            