exports.config =
    # See docs at http://brunch.readthedocs.org/en/latest/config.html.
    coffeelint:
        pattern: /^app\/.*\.coffee$/
        options:
            indentation:
                value: 4
                level: "error"
    files:
        javascripts:
            joinTo:
                'javascripts/app.js': /^app/
                'javascripts/head.js': /^vendor(\/|\\)head/
                'javascripts/vendor.js': /^vendor(\/|\\)(?!head|test)/
                'test/javascripts/test-vendor.js': /^vendor(\/|\\)test/
                'test/javascripts/test.js': /^test/
            order:
                # Files in `vendor` directories are compiled before other files
                # even if they aren't specified in order.
                before: [
                    'vendor/scripts/json2.js'
                    'vendor/scripts/jquery.js'
                    'vendor/scripts/underscore.js'
                    'vendor/scripts/backbone.js'
                ]
                after: [
                    'vendor/test/scripts/test-helper.js'
                ]

        stylesheets:
            joinTo: 
                'stylesheets/app.css': /^(app|vendor(\/|\\)(?!test))/
                'test/stylesheets/test.css': /^test|vendor(\/|\\)test/
            order:
                before: [
                    'vendor/styles/normalize.css'
                    'vendor/styles/base.css'
                    'vendor/styles/bootstrap.css'
                    'vendor/styles/bootstrap-responsive.css'
                ]
                after: [
                    'vendor/styles/helpers.css'
                ]
        templates:
            joinTo: 'javascripts/app.js'
    server:
        path: 'server.coffee'
        port: 3333
        base: '/'
        watched: ['express/config.coffee', 'express/index.coffee', 'express/lib', 'express/models', 'express/routes']
        ignored: /(^[.#]|(?:~)$)/
