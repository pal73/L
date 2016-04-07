var http = require("http");
var url = require("url");

function start() {
  function onRequest(request, response) {
  	var urlname = url.parse(request.url).pathname;
    console.log("Request for " + urlname + " received.");
    response.writeHead(200, {"Content-Type": "text/plain"});
    response.write("Hello World" + urlname);
    response.end();
  }

  http.createServer(onRequest).listen(8888);
  console.log("Server has started.");
}


exports.starttt = start;