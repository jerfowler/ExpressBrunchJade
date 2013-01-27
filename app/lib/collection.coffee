module.exports = Collection = Backbone.Collection.extend(
    resetSilent: (models, options) ->
        options = options or {}
        @reset models, _.extend {}, options, silent: yes
)