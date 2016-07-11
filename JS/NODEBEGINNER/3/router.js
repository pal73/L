function _route( _handle, _pathname) {
  if (typeof _handle[_pathname] === 'function') {
  	//_handle[_pathname]();
    return _handle[_pathname]();
  } else {
    console.log("No request handler found for " + _pathname);
    return "404 Not found";
  }
  //console.log("About to route a request for " + _pathname);
}

exports.routeee = _route;