var _ = require('lodash');

var worker = function(collection) {
    return _.forEach(collection, function(obj) {
        return obj.population >= 1.0 ? obj.size = 'big' : obj.population < 0.5 ? obj.size = 'small' : obj.size = 'med';
    });
};

module.exports = worker;