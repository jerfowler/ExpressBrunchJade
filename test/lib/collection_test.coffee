Collection = require 'lib/collection'

describe 'lib/collection', ->
    beforeEach ->
        @collection = new Collection()
        @spy = sinon.spy()
        @collection.on 'reset', @spy

    describe 'resetSilent', ->
        it 'Should not triger reset event', ->
            models = [{name: 'one', value: 1}, {name: 'two', value: 2}]
            @collection.resetSilent(models)
            @spy.should.not.have.been.called
