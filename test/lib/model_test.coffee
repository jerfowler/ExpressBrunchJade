Model = require 'lib/model'

class ModelTest extends Model

    defaults: 
        name: ''
        value: 0

    validate: (attrs) ->
        return 'value needs to be greater than 0' if attrs.value < 0

describe 'lib/model', ->
    beforeEach ->
        @model = new ModelTest()

    afterEach ->
        @model.destroy()

    describe 'setSilent', ->
        it 'Accepts object style', ->
            @model.setSilent({name: 'foo'})
            expect( @model.get('name')).to.equal('foo')

        it 'Accepts parameter style', ->
            @model.setSilent('name', 'foo')
            expect( @model.get('name')).to.equal('foo')

    describe 'setValid', ->
        it 'Accepts object style', ->
            @model.setValid({name: 'foo'})
            expect( @model.get('name')).to.equal('foo')

        it 'Accepts parameter style', ->
            @model.setValid('name', 'foo')
            expect( @model.get('name')).to.equal('foo')

        it 'Validates values when set', ->
            result = @model.setValid('value', -1)
            expect(result).to.be.false