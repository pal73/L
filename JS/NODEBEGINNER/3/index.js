var server = require("./server");
var router = require("./router");
var requestHandlers = require("./requestHandlers");

var handle = {}
handle["/"] = requestHandlers.starttt;
handle["/start"] = requestHandlers.starttt;
handle["/upload"] = requestHandlers.uploaddd;

server.starttt(router.routeee, handle);



//server.starttt(router.routeee);