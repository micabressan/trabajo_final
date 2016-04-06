var http = require("http");
var port = 3000;
var serverUrl = "http://63.142.250.99/";

var server = http.createServer(function(req, res) {

  console.log("Request: " + req.url);
  
  var now = new Date();
  var html = "Hello world";
  res.end(html);

});

console.log("Listening at " + serverUrl + ":" + port);
server.listen(port, serverUrl);