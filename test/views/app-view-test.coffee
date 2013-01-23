AppView = require 'views/app_view'

class AppViewTest extends AppView
  renderTimes: 0

  render: ->
    super
    @renderTimes += 1

describe 'AppView', ->
  beforeEach ->
    @view = new AppViewTest()

  afterEach ->
    @view.destroy()

  it "should exist", ->
    expect( @view ).to.be.ok()
