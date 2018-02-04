'use strict';
'use os';

console.log('Loading function');

exports.handler = (event, context, callback) => {
    
    var os = require('os');
    callback(null, {
        statusCode: '200',
        body: 'Ahoj przygodo:' + os.hostname(),
        headers: {
            'Content-Type': 'text/plain'
        }
    })
};