game.newLoop('menu', function () {
	game.clear();

	var pos=touch.getPosition();

	var newGame=game.newBaseObject({
		x:width/2-100,y:height/2-30,
		w:200,h:30
	});

	brush.drawText({
		text:'Новая игра',
		x:width/2,y:height/2-30,
		size:30,
		align:'center',
		stile:'italic bold',
		color:'#FD0202'

	});


	brush.drawText({
		text:'Выход',
		x:width/2,y:height/2+30,
		size:30,
		align:'center',
		stile:'italic bold',
		color:'#FD0202'

	});

	//newGame.drawStaticBox("Red");
	if(touch.isPeekStatic(newGame.getStaticBox())) {
		game.startLoop('game');
		//log('1');
	}

	if(touch.isDown()) {
		brush.drawCircle({
			x:pos.x-20,
			y:pos.y-20,
			radius:20,
			fillColor:'#BA2EAB'
		});
	}
});

game.setLoop('menu');
game.start();