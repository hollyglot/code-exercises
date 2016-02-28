
var _ = require("lodash");
var peeps = [{ id: 22, username: "martin", active: true},
      { id: 23, username: "max",    active: false},
      { id: 24, username: "linda",  active: false}];

var worker = function(obj) {
  return _.where(obj, ['active']);
};

// export the worker function as a nodejs module
module.exports = worker(peeps);