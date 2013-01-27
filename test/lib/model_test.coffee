Model = require 'lib/model'

class ModelTest extends Model

    defaults: 
        name: 'test'
        value: 0

    set: (key, val, options) ->
        super

    validate: (attrs) ->
        return 'value needs to be greater than 0' if attrs.value < 0

describe 'lib/model', ->
    beforeEach ->
        @model = new ModelTest()
        @spy = sinon.spy(@model, 'set')

    afterEach ->
        @model.set.restore()
        @model.destroy()

    describe 'setSilent', ->
        it 'Accepts object style', ->
            @model.setSilent({name: 'foo'})
            expect( @model.get('name') ).to.equal('foo')

        it 'Accepts parameter style', ->
            @model.setSilent('name', 'foo')
            expect( @model.get('name') ).to.equal('foo')

        it 'Accepts object style extended options', ->
            extended = silent: true, test: true
            @model.setSilent({'name':'foo'}, test: true)
            @spy.should.have.been.calledWith({'name':'foo'}, extended)    

        it 'Accepts parameter style extended options', ->
            extended = silent: true, test: true
            @model.setSilent('name', 'foo', test: true)
            @spy.should.have.been.calledWith({'name':'foo'}, extended)

        it 'Should not modify original passed options', ->
            options = test: true
            @model.setSilent('name', 'foo', options)
            options.should.eql(test: true)

        it 'Should override passed silent option', ->
            extended = silent: true
            @model.setSilent({'name':'foo'}, silent: false)
            @spy.should.have.been.calledWith({'name':'foo'}, extended)              

    describe 'setValid', ->
        beforeEach ->
            @callback = sinon.spy()
            @model.on("invalid", @callback)

        afterEach ->
            @model.off("invalid", @callback)

        it 'Accepts object style', ->
            @model.setValid({name: 'foo'})
            expect( @model.get('name') ).to.equal('foo')

        it 'Accepts parameter style', ->
            @model.setValid('name', 'foo')
            expect( @model.get('name') ).to.equal('foo')

        it 'Accepts object style extended options', ->
            extended = validate: true, test: true
            @model.setValid({'name':'foo'}, test: true)
            @spy.should.have.been.calledWith({'name':'foo'}, extended)    

        it 'Accepts parameter style extended options', ->
            extended = validate: true, test: true
            @model.setValid('name', 'foo', test: true)
            @spy.should.have.been.calledWith({'name':'foo'}, extended)

        it 'Should not modify original passed options', ->
            options = test: true
            @model.setValid('name', 'foo', options)
            options.should.eql(test: true)

        it 'Should override passed validate option', ->
            extended = validate: true
            @model.setValid({'name':'foo'}, validate: false)
            @spy.should.have.been.calledWith({'name':'foo'}, extended)  

        it 'Returns false when validation fails', ->
            result = @model.setValid('value', -1)
            result.should.be.false

        it 'Triggers "invalid" event when validation fails', ->
            @model.setValid('value', -1)
            @callback.should.have.been.calledWith(@model, 'value needs to be greater than 0')

    describe 'pop', ->
        beforeEach ->
            @model.set('numSet', [0,1,2,3,4,5])

        afterEach ->
            @model.unset('numSet')

        it 'Remove an item from the end of the attribute', ->
            @model.pop('numSet')
            expect(@model.get('numSet')).to.eql([0, 1, 2, 3, 4 ])

        it 'Returns the last item from the end of the attribute', ->
            item = @model.pop('numSet')
            item.should.equal(5)

    describe 'push', ->
        beforeEach ->
            @model.set('numSet', [0,1,2,3,4,5])

        afterEach ->
            @model.unset('numSet')

        it 'Add an item to the end of the attribute', ->
            @model.push('numSet', 6)
            expect(@model.get('numSet')).to.eql([0, 1, 2, 3, 4, 5, 6])

        it 'Add a set of items to the end of the attribute', ->
            @model.push('numSet', 6, 7, 8, 9)
            expect(@model.get('numSet')).to.eql([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])

        it 'Returns the new length of the array', ->
            length = @model.push('numSet', 6, 7, 8, 9)
            length.should.equal(10)

    describe 'shift', ->
        beforeEach ->
            @model.set('numSet', [2,3,4,5])

        afterEach ->
            @model.unset('numSet')

        it 'Remove an item from the end of the attribute', ->
            @model.shift('numSet')
            expect(@model.get('numSet')).to.eql([3,4,5])

        it 'Return the last item from the end of the attribute', ->
            item = @model.shift('numSet')
            item.should.equal(2)

    describe 'unshift', ->
        beforeEach ->
            @model.set('numSet', [2,3,4,5])

        afterEach ->
            @model.unset('numSet')

        it 'Add an item to the end of the attribute', ->
            @model.unshift('numSet', 1)
            expect(@model.get('numSet')).to.eql([1, 2, 3, 4, 5])

        it 'Add a set of items to the end of the attribute', ->
            @model.unshift('numSet', -1, 0, 1)
            expect(@model.get('numSet')).to.eql([-1, 0, 1, 2, 3, 4, 5])

        it 'Returns the new length of the array', ->
            length = @model.unshift('numSet', -1, 0, 1)
            length.should.equal(7)

    describe 'splice', ->
        beforeEach ->
            @model.set('numSet', [2,3,4,5])

        afterEach ->
            @model.unset('numSet')

        it 'Adds and removes items', ->
            @model.splice('numSet', 0, 2, 1, 2, 3)
            expect(@model.get('numSet')).to.eql([1,2,3,4,5])

        it 'Returns the items removed', ->
            items = @model.splice('numSet', 0, 2, 1, 2, 3)
            items.should.eql([2,3])

    describe 'sort', ->
        beforeEach ->
            @model.set('numSet', [6,2,1,4,3,5])

        afterEach ->
            @model.unset('numSet')  

        it 'Sorts the items', ->
            @model.sort('numSet')
            expect(@model.get('numSet')).to.eql([1,2,3,4,5,6])

        it 'Sorts by the provided compare function', ->
            @model.sort('numSet', (a,b) ->
                return 1 if a < b
                return -1 if a > b
                return 0 if a is b
            )
            expect(@model.get('numSet')).to.eql([6,5,4,3,2,1])

        it 'Returns the model object', ->
            model = @model.sort('numSet')
            model.should.equal(@model)

    describe 'reverse', ->
        beforeEach ->
            @model.set('numSet', [2,3,4,5])

        afterEach ->
            @model.unset('numSet')            

        it 'Reverses the items', ->
            @model.reverse('numSet')
            expect(@model.get('numSet')).to.eql([5,4,3,2])     

        it 'Returns the model object', ->
            model = @model.reverse('numSet')
            model.should.equal(@model)            

    describe 'add', ->
        beforeEach ->
            @model.set('value', 0)

        afterEach ->
            @model.unset('value')

        it 'Adds the values', ->
            @model.add('value', 6, 7, 8)
            expect(@model.get('value')).to.equal(21) 

        it 'Returns the model object', ->
            model = @model.add('value', 6, 7, 8)
            model.should.equal(@model)              
      

    describe 'subtract', ->
        beforeEach ->
            @model.set('value', 21)

        afterEach ->
            @model.unset('value')

        it 'Subtracts the values', ->
            @model.subtract('value', 6, 7, 8)
            expect(@model.get('value')).to.equal(0) 
            
        it 'Returns the model object', ->
            model = @model.subtract('value', 6, 7, 8)
            model.should.equal(@model)   

    describe 'divide', ->
        beforeEach ->
            @model.set('value', 1000)

        afterEach ->
            @model.unset('value')

        it 'Divides by the values', ->
            @model.divide('value', 10, 5)
            expect(@model.get('value')).to.equal(20) 
            
        it 'Returns the model object', ->
            model = @model.divide('value', 10, 5)
            model.should.equal(@model)   

    describe 'multiply', ->
        beforeEach ->
            @model.set('value', 1)

        afterEach ->
            @model.unset('value')

        it 'Multiplies by the values', ->
            @model.multiply('value', 6, 7, 8)
            expect(@model.get('value')).to.equal(336) 
            
        it 'Returns the model object', ->
            model = @model.multiply('value', 6, 7, 8)
            model.should.equal(@model)              
