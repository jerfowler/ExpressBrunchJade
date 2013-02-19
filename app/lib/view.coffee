module.exports = View = Backbone.View.extend(

    type: 'view'

    name: null

    debug: off

    autoRender: off

    rendered: no

    model: null

    mixins: {}

    # jQuery Shortcuts
    html: (dom) ->
        return @$el.html() unless dom?
        @$el.html(dom)
        @trigger "change:DOM", @
        @$el

    append: (dom) ->
        @$el.append(dom)
        @trigger "change:DOM", @
        @$el

    prepend: (dom) ->
        @$el.prepend(dom)
        @trigger "change:DOM", @
        @$el

    attr: (prop, value) ->
        @$el.attr(prop, value)

    css: (prop, value) ->
        @$el.css(prop, value)

    find: (selector) ->
        @$el.find(selector)

    #template function should be overridden in descendants
    template: (data) -> 'REPLACE ME'

    templateData: ->
        _.extend (@model?.toJSON() or {}), @mixins

    setModel: (model) ->
        @stopListening(@model) if @model?
        @model = model
        @render() if @autoRender is on
        if @model?
            @listenTo @model, 'change', @render
            @listenTo @model, 'destroy', @destroy
        @trigger "change:model", @
        @

    startDebugging: ->
        @on "initialize", -> console.debug "Initialized #{@name}: #{@cid}",@
        @on "change:DOM", -> console.debug "DOM Changed #{@name}: #{@cid}",@
        @on "change:model", -> console.debug "Model Changed #{@name}: #{@cid}",@
        @on "render", -> console.debug "Rendered #{@name}: #{@cid}",@
        @on "destroy", -> console.debug "Destroyed #{@name}: #{@cid}",@

    initialize: ->
        @trigger "initialize:before", @
        @name = @name or @constructor.name or 'View'
        @startDebugging() if @debug is on
        @render() if @autoRender is on
        if @model?
            @listenTo @model, 'change', @render
            @listenTo @model, 'destroy', @destroy
        @trigger "initialize", @

    render: ->
        @trigger "render:before", @
        @attr 'data-cid', @cid
        @html @template @templateData()
        @rendered = yes
        @trigger "render", @
        @

    destroy: ->
        @trigger "destroy:before", @
        @remove()
        @trigger "destroy", @
)