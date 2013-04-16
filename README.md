#Express Brunch with Jade

Express Brunch with Jade is a [Brunch](http://brunch.io/) app skeleton that has everything [hipsters](https://github.com/elving/brunch-with-hipsters) has, but adds a custom Express Server, public & server file watcher, built-in socket.io reload, custom Backbone model/view/collection helpers, Jade client & server side templates and over 70 mocha BDD tests.

Express Brunch with Jade's custom server.coffee file watches any files you specify, server and/or public static file compiled by brunch, reloads the Express App and sends a socket.io reload command to the client when it detects a change. 

Files & Directories that are watched and ignored are configured under the server section in the config.coffee:

example:
```coffeescript
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
```

## Cordell Walker - CI Ranger

The server walk and watch functionality has been made into its own module called Cordell. 
- [Cordell](https://github.com/jerfowler/cordell)

## Languages

- [CoffeeScript](http://coffeescript.org/)
- [Stylus](http://learnboost.github.com/stylus/)
- [Jade](http://jade-lang.com/)

## Features
- [Express v3.2.0](http://expressjs.com)
- [Jade-Brunch 1.5.0](https://github.com/brunch/jade-brunch)
- [HTML5 Boilerplate v4.1.0](https://github.com/h5bp/html5-boilerplate)
- [Twitter Bootstrap v2.3.1](http://twitter.github.com/bootstrap)
- [Font Awesome v3.0.2](https://github.com/FortAwesome/Font-Awesome)
- [Backbone v1.0.0](http://backbonejs.org)
- [Underscore 1.4.4](http://underscorejs.org)
- [jQuery v1.9.1](http://jquery.com)
- [Normalize.css v1.1.0](http://necolas.github.com/normalize.css)
- [Modernizr v2.6.2](https://github.com/Modernizr/Modernizr)
- [Coffeelint 1.4.4](https://github.com/ilkosta/coffeelint-brunch)

## Testing Framework

- [Mocha v1.8.1](http://visionmedia.github.com/mocha)
- [Chai v1.4.1](http://chaijs.com)
- [Sinon v1.5.2](http://sinonjs.org)
- [Sinon-Chai v2.3.1](http://chaijs.com/plugins/sinon-chai)

## Code Coverage Framework

- [Blanket v1.1.1](https://github.com/alex-seville/blanket)

## Getting started

    brunch new <appname> --skeleton git://github.com/jerfowler/ExpressBrunchJade.git
    cd <appname>
    brunch w -s

or

    $ git clone git://github.com/jerfowler/ExpressBrunchJade.git
    $ cd ExpressBrunchJade
    $ npm install
    $ brunch w -s

or

    $ git clone git://github.com/jerfowler/ExpressBrunchJade.git && cd ExpressBrunchJade && npm install && brunch w -s

## Optimization Plugins

The traditional uglify-brunch plugin has been replaced with ugly-blanket-brunch, which creates separate cov.js and min.js files.
- [ugly-blanket-brunch v1.5.2](https://github.com/jerfowler/ugly-blanket-brunch)

Optimization must be enabled when starting brunch

    $ brunch w -s -o


## Testing

The `brunch test` command is pretty much broke. It uses jsdom, which has many issues... Plans are in the works for brunch to use phantomjs in the future. Until then, there are better ways to run tests:

### Mocha in the browser, Just open your browser to `http://localhost:3333/test/` after running:

    brunch w -s -o
  
Note: Doesn't work in IE. Some tests fail with `global leak detected` in firefox if firebug isn't on... 

### mocha-phantomjs 

    npm install -g mocha-phantomjs
    mocha-phantomjs public/test/index.html

Note: Windows phantomjs support is sketchy (path issues)

### Karma!!! (Formally Testacular) Best approach, multiple browser tests (including phantomjs)...

    npm install -g karma
    karma start --browsers Chrome,ChromeCanary,Firefox,PhantomJS

Note: On Windows x64, use `karma.x64_ENV.bat` to help with browser paths

## Debugging

Brunch debug events can be monitored by setting the `DEBUG=brunch:*` environment variable. 