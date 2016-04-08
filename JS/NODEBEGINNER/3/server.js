var http = require("http");
var url = require("url");

function start(route, handle) {
  function onRequest(request, response) {
  	var urlname = url.parse(request.url).pathname;
    console.log("Request for " + urlname + " received.");

	var content = route(handle, urlname);

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.write(content);
    response.end();
  }

  http.createServer(onRequest).listen(8888);
  console.log("Server has started.");
}


exports.starttt = start;