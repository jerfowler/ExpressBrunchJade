Collection = require 'lib/collection'

class CollectionTest extends Collection

    reset: (models, options) ->
        super

describe 'lib/collection', ->
    beforeEach ->
        @collection = new CollectionTest()
        @callback = sinon.spy()
        @collection.on("reset", @callback)

    afterEach ->
        @collection.off("reset", @callback)

    describe 'resetSilent', ->
        it 'Should not triger reset', ->
            models = [{name: 'one', value: 1}, {name: 'two', value: 2}]
            @collection.resetSilent(models)            
            @callback.should.not.have.been.called
