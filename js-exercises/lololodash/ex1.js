use 'strict'
var _ = require("lodash")

var worker = function(obj) {
  return _.where(obj, ['active'])
}

// export the worker function as a nodejs module
module.exports = worker