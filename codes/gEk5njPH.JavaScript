var http = require('http');
var server = http.createServer(function (req, res) {
    res.writeHead(200, {'Content-type': 'text/html'});
    res.end('Hello Node!');
});
server.listen(3000);
console.log('Servidor iniciado. Acesse: localhost:3000');