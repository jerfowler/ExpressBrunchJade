AppView = require 'views/app_view'

AppViewTest = AppView.extend(
    name: 'AppViewTest'

    debug: off

    autoRender: off

    renderTimes: 0

    bootstrap: ->  
)

AppViewTest::render = ->
    super
    @renderTimes += 1

describe 'AppViewTest', ->
    beforeEach ->
        @view = new AppViewTest()
        @view.render()

    afterEach ->
        @view.destroy()

    it "should exist", ->
        # expect( @view ).to.be.ok
        should.exist(@view)

    it "should have rendered only once", ->
        # expect( @view ).to.have.property('renderTimes')
        #   .and.equal(1)
        @view.should.have.property('renderTimes').and.equal(1)