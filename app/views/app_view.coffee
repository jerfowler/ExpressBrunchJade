View = require 'lib/view'

module.exports = AppView = View.extend(
    el: '#AppView'

    name: 'AppView'

    debug: on

    autoRender: on

    template: require 'views/templates/app_view'
)