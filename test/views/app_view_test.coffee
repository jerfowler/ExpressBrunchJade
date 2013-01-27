AppView = require 'views/app_view'

class AppViewTest extends AppView
  renderTimes: 0

  render: ->
    super
    @renderTimes += 1

describe 'AppView', ->
  beforeEach ->
    @view = new AppViewTest()
    @view.render()

  afterEach ->
    @view.destroy()

  it "should exist", ->
    # expect( @view ).to.be.ok
    should.exist(@view)

  it "should have rendered", ->
    # expect( @view ).to.have.property('rendered')
    #   .and.to.be.true
    @view.should.have.property('rendered').and.be.true


  it "should have rendered only once", ->
    # expect( @view ).to.have.property('renderTimes')
    #   .and.equal(1)
    @view.should.have.property('renderTimes').and.equal(1)