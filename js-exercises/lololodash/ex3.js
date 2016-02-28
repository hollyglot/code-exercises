var _ = require('lodash');

var worker = function(collection) {
    var results = { hot: [], warm: []} ;
    function checktemp(temp) {
        return temp > 19;
    }
    return _.forEach(collection, function(obj, key) {
       if (_.every(obj, checktemp)) {
        return results.hot.push(key)
       } else if (_.some(obj, checktemp) {
        return results.warm.push(key)
       }
    });
};

module.exports = worker;