exports.config = 
    view: 
        engine: 'jade'
    
    cookie: 
        secret: 'Express Brunch Rules!'

    server:
        watched: 
            files: ['express/config.coffee', 'express/index.coffee']
            dirs: ['express/lib', 'express/models', 'express/routes']
