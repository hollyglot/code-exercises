var _ = require('lodash');

var worker = function(collection) {
    var results = {} ;
    return _.forEach(collection, function(obj) {
       if (_.every(obj, (>19))) {
        return (results['hot'] || results['hot'] = []).push(key)
       } else if (_.some(obj, (>19))) {
        return (results['warm'] || results['warm'] = []).push(key)
       }
    });
};

module.exports = worker;