var counter = 0;
var counter0 = 0;
var timeHandler = function() {
	counter0++;
	if(counter0 >= 100) {
		counter0 = 0;
		counter++;
		
	}
	console.log(counter);
	//setTimeout(timeHandler,1000);
}

//timeHandler();
setInterval(timeHandler,10);


//server.starttt(router.routeee);