exports.config =
    # See docs at http://brunch.readthedocs.org/en/latest/config.html.
    coffeelint:
        pattern: /^.*\.coffee$/
        options:
            indentation:
                value: 4
                level: "error"
    plugins:
        uglify:
            pattern: /\.js$/

    files:
        javascripts:
            joinTo:
                'javascripts/app.js': /^app/
                'javascripts/head.js': /^vendor(\/|\\)head/
                'javascripts/vendor.js': /^vendor(\/|\\)(?!head|test)/
                'test/javascripts/test-vendor.js': /^vendor(\/|\\)test(\/|\\)scripts(\/|\\)(?!blanket|mocha-blanket)/
                'test/javascripts/blanket.js': /^vendor(\/|\\)test(\/|\\)scripts(\/|\\)(blanket|mocha-blanket)/
                'test/javascripts/test.js': /^test/
            order:
                # Files in `vendor` directories are compiled before other files
                # even if they aren't specified in order.
                before: [
                    'vendor/scripts/json2.js'
                    'vendor/scripts/jquery-1.9.1.js'
                    'vendor/scripts/underscore-1.4.4.js'
                    'vendor/scripts/backbone-1.0.0.js'
                ]
                after: [
                    'vendor/test/scripts/blanket-1.1.1.js'
                    'vendor/test/scripts/mocha-blanket-1.1.1.js'
                    'vendor/test/scripts/test-helper.js'
                    'vendor/scripts/brunch-reload.js'
                ]

        stylesheets:
            joinTo:
                'stylesheets/app.css': /^(app|vendor(\/|\\)(?!test))/
                'test/stylesheets/test.css': /^test|vendor(\/|\\)test/
            order:
                before: [
                    'vendor/styles/normalize-1.1.0.css'
                    'vendor/styles/h5bp-base-4.1.0.css'
                    'vendor/styles/bootstrap-2.3.1.css'
                ]
                after: [
                    'vendor/styles/h5bp-helpers-4.1.0.css'
                ]
        templates:
            joinTo: 'javascripts/app.js'
    server:
        path: 'server.coffee'
        port: 3333
        base: '/'
        app: 'express'
        debug: 'brunch:server'
        persistent: true
        interval: 100
        watched: ['public', 'express']
        ignore: /(^[.#]|(?:~)$)/
        source: /.*\.coffee$/
        linter:
            enabled: on
            coffeelint:
                pattern: /.*\.coffee$/
                options:
                    indentation:
                        value: 4
                        level: "error"
        tester:
            enabled: on
            mocha:
                pattern: /^.*_test\.coffee$/
                options:
                    reporter:'spec'