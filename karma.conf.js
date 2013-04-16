// Testacular configuration
// Generated on Fri Feb 15 2013 17:16:45 GMT-0600 (Central Standard Time)


// base path, that will be used to resolve files and exclude
basePath = 'public';


// list of files / patterns to load in the browser
files = [
  "javascripts/head.js",
  "javascripts/vendor.js",
  "javascripts/app.js",
  "test/javascripts/test-vendor.js",
  MOCHA_ADAPTER,
  "test/javascripts/test.js"
];


// list of files to exclude
exclude = [
  
];


// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress'];


// web server port
port = 8080;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
// Best to use CLI option --browsers (eg. --browsers Chrome,ChromeCanary,Firefox)
browsers = [];


// If browser does not capture in given timeout [ms], kill it
captureTimeout = 5000;


// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;
