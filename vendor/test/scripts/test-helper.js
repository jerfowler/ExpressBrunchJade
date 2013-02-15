// Create `window.describe` etc. for our BDD-like tests.
window.mocha.setup({ui: 'bdd'});

// Create another global variable for simpler syntax.
window.expect = chai.expect;

// Alternative should syntax
var should = chai.should();