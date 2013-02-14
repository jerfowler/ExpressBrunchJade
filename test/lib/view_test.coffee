View = require 'lib/view'

describe 'lib/view', ->
    describe 'initialize', ->
        beforeEach ->
            @ViewTest = View.extend()
            @spys = {
                debug: sinon.spy @ViewTest.prototype, 'startDebugging'
                render: sinon.spy @ViewTest.prototype, 'render' 
                before: sinon.spy()
                after: sinon.spy()
            }
            @ViewTest::on('initialize:before', @spys.before)
            @ViewTest::on('initialize', @spys.after)

        afterEach ->
            @view.destroy()  

        it 'Should trigger: initialize:before', ->
            @view = new @ViewTest()
            @spys.before.should.have.been.called

        it 'Should trigger: initialize', ->
            @view = new @ViewTest()
            @spys.after.should.have.been.called

        describe 'property: debug', ->
            it 'When on, should call: startDebugging', ->
                @ViewTest::debug = on
                @view = new @ViewTest()
                @spys.debug.should.have.been.called

            it 'When off, should not call: startDebugging', ->
                @ViewTest::debug = off
                @view = new @ViewTest()
                @spys.debug.should.not.have.been.called

        describe 'property: autoRender', ->
            it 'When on, should call: render', ->
                @ViewTest::autoRender = on
                @view = new @ViewTest()
                @spys.render.should.have.been.called

            it 'When off, should not call: render', ->
                @ViewTest::autoRender = off
                @view = new @ViewTest()
                @spys.render.should.not.have.been.called

    describe 'render', ->
        beforeEach ->
            ViewTest = View.extend(
                autoRender: on
            )
            @spys = {
                attr: sinon.spy ViewTest.prototype, 'attr'
                html: sinon.spy ViewTest.prototype, 'html'
                tmpl: sinon.spy ViewTest.prototype, 'template' 
                data: sinon.spy ViewTest.prototype, 'templateData'
                before: sinon.spy()
                after: sinon.spy()
            }
            ViewTest::on('render:before', @spys.before)
            ViewTest::on('render', @spys.after)
            @view = new ViewTest()

        afterEach ->
            @view.destroy()        

        it 'Should trigger: render:before', ->
            @spys.before.should.have.been.called

        it "Should have called: attr", ->
            @spys.attr.should.have.been.called

        it "Should have called: templateData", ->
            @spys.data.should.have.been.called

        it "Should have called: template", ->
            @spys.tmpl.should.have.been.called

        it "Should have called: html", ->
            @spys.html.should.have.been.called

        it "Should set property: rendered, to be true", ->
            @view.should.have.property('rendered').and.be.true

        it 'Should trigger: render', ->
            @spys.after.should.have.been.called

        it "Should be chainable (returns this)", ->
            result = @view.render()
            expect(result).to.equal(@view)
