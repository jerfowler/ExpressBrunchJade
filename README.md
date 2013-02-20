#Express Brunch with Jade

Express Brunch with Jade is a [Brunch](http://brunch.io/) app skeleton that is based on hipsters but adds a custom Express Server and Jade client & server side templates. If Brunch with Hipsters was awesome before awesome was awesome. Express Brunch with Jade is just pure sweetness...

## Languages

- [CoffeeScript](http://coffeescript.org/)
- [Stylus](http://learnboost.github.com/stylus/)
- [Jade](http://jade-lang.com/)

## Features
- [Express v3.0.5](http://expressjs.com)
- [Jade-Brunch 1.5.0](https://github.com/brunch/jade-brunch)
- [HTML5 Boilerplate v4.0.3](https://github.com/h5bp/html5-boilerplate)
- [Twitter Bootstrap v2.2.2](http://twitter.github.com/bootstrap)
- [Font Awesome v3.0.2](https://github.com/FortAwesome/Font-Awesome)
- [Backbone v0.9.10](http://backbonejs.org)
- [Underscore 1.4.3](http://underscorejs.org)
- [jQuery v1.9.0](http://jquery.com)
- [Normalize.css v2.1.0](http://necolas.github.com/normalize.css)
- [Modernizr v2.6.2](https://github.com/Modernizr/Modernizr)
- [Brunch Auto-Reload v1.3.2](https://github.com/brunch/auto-reload-brunch)
- [Coffeelint 1.4.4](https://github.com/ilkosta/coffeelint-brunch)

## Testing Framework

- [Mocha](http://visionmedia.github.com/mocha)
- [Chai](http://chaijs.com)
- [Sinon](http://sinonjs.org)
- [Sinon-Chai](http://chaijs.com/plugins/sinon-chai)

## Getting started

    brunch new <appname> --skeleton git://github.com/jerfowler/ExpressBrunchJade.git
    brunch w -s

or

    $ git clone git://github.com/jerfowler/ExpressBrunchJade.git
    $ npm install
    $ brunch w -s

or

    $ git clone git://github.com/jerfowler/ExpressBrunchJade.git && npm install && brunch w -s

## Testing

The `brunch test` command is pretty much broke. It uses jsdom, which has many issues... Plans are in the works for brunch to use phantomjs in the future. Until then, there are better ways to run tests:

### Mocha in the browser, Just open your browser to `http://localhost:3333/test/` after running:

    brunch w -s
  
Note: Doesn't work in IE. Some tests fail with `global leak detected` in firefox if firebug isn't on... 

### mocha-phantomjs 

    npm install -g mocha-phantomjs
    mocha-phantomjs public/test/index.html

Note: Windows phantomjs support is sketchy (path issues)

### Testacular!!! Best approach, multiple browser tests (including phantomjs)...

    npm install -g testacular
    testacular start --browsers Chrome,ChromeCanary,Firefox,PhantomJS

Note: On Windows x64, use `testacular.x64_ENV.bat` to help with browser paths