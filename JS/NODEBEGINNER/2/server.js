var http = require("http");

http.createServer(function(request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.write("Hello World11");
  response.end();
}).listen(8888);
console.log("Hello World");