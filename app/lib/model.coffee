module.exports = Model = Backbone.Model.extend(
    setSilent: (key, val, options) ->
        if typeof key is 'object'
            attrs = key
            options = val or {}
        else
            (attrs = {})[key] = val
            options = options or {}

        @set attrs, _.extend {}, options, silent: yes

    setValid: (key, val, options) ->
        if typeof key is 'object'
            attrs = key
            options = val or {}
        else
            (attrs = {})[key] = val
            options = options or {}

        @set attrs, _.extend {}, options, validate: true

    pop: (attribute) ->
        attr = @get attribute
        item = attr.pop()
        (obj = {})[attribute] = attr
        @set obj

        item

    push: (attribute, values...) ->
        attr = @get attribute
        length = attr.push values...
        (obj = {})[attribute] = attr
        @set obj

        length

    shift: (attribute) ->
        attr = @get attribute
        item = attr.shift()
        (obj = {})[attribute] = attr
        @set obj

        item

    unshift: (attribute, values...) ->
        attr = @get attribute
        length = attr.unshift values...
        (obj = {})[attribute] = attr
        @set obj

        length

    splice: (attribute, values...) ->
        attr = @get attribute
        items = attr.splice values...
        (obj = {})[attribute] = attr
        @set obj

        items

    reverse: (attribute) ->
        attr = @get attribute
        items = attr.reverse()
        (obj = {})[attribute] = attr

        @set obj

    sort: (attribute, fn) ->
        attr = @get attribute
        attr.sort fn
        (obj = {})[attribute] = attr

        @set obj

    add: (attribute, values...) ->
        attr = @get attribute
        attr += value for value in values
        (obj = {})[attribute] = attr

        @set obj

    subtract: (attribute, values...) ->
        attr = @get attribute
        attr -= value for value in values
        (obj = {})[attribute] = attr

        @set obj

    divide: (attribute, values...) ->
        attr = @get attribute
        attr /= value for value in values
        (obj = {})[attribute] = attr

        @set obj

    multiply: (attribute, values...) ->
        attr = @get attribute
        attr *= value for value in values
        (obj = {})[attribute] = attr

        @set obj
)