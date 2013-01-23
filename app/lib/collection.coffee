module.exports = Collection = Backbone.Collection.extend(
    resetSilent: (models) ->
        @reset(models, silent: yes)
)