var style = {
	backgroundColor : '#767676'
 // other
};

var gjs = new PointJS('2d', 400, 200, style);

var game    = gjs.game;
var sys     = gjs.system;
var key     = gjs.keyControl;
var mouse   = gjs.mouseControl;
var touch   = gjs.touchControl;
var vector  = gjs.vector;
var point   = vector.point;
var v2d     = vector.v2d;
var v2f     = vector.v2d;
var size    = vector.size;
var brush   = gjs.brush;
var math    = gjs.math;
var random  = math.random;
var colors  = gjs.colors;
var h2r     = colors.hex2rgb;
var log     = sys.log;
var stop     = game.stop;
var audio   = gjs.audio;
var tiles   = gjs.tiles;
var OOP = gjs.OOP;
var limit = math.limit;

var isDef = OOP.isDef;

var width = sys.getWH().w;
var height = sys.getWH().h;

sys.addEvent('gameResize', 'PointJS_DEMO_resize', function () {
	width = sys.getWH().w ;
	height = sys.getWH().h;
});

sys.setSettings({
	isShowError : false,
	isAutoClear : true,
// isAutoDraw : true
});

touch.initTouchControl();
sys.initFullPage();
sys.initFPSCheck();
key.initKeyControl();
mouse.initMouseControl();

var drawFPS = function (color) {
	brush.drawText({
		x : mouse.getPosition().x, y : mouse.getPosition().y,
		text : 'FPS: '+sys.getFPS(),
		color : color || 'white',
		size : 20
	});
};

var drawHELP = function (x, y, arr, color) {
	brush.drawTextLines({
		x : x, y : y,
		lines : arr || 'Демонстрационное приложение',
		color : color || 'white',
		size : 20
	});
};

var logo = game.newImageObject({
	x : width / 4, y : height / 4,
	w : 170, h : 100,
	file : 'imgs/logo.png',
	alpha : 0
});

var tree = game.newImageObject({
	x : width / 2, y : height,
	w : 100, h : 100,
	file : 'imgs/tree.png',
	alpha : 0
});

var house = game.newImageObject({
	x : width / 5, y : height - 100,
	w : 130, h : 130,
	file : 'imgs/house.png',
	alpha : 0
});

var floor = game.newRectObject({
	x : 0, y : height,
	w : width, h : height,
	fillColor : '#68BD5A',
	alpha : 0
});

var sky = game.newRectObject({
	x : 0, y : 0,
	w : width, h : height,
	fillColor : '#669CBF',
	alpha : 0
});

var sun = game.newCircleObject({
	x : width - 50, y : -50,
	radius : 50,
	fillColor : '#FFF686',
	alpha : 0
});

var cycling = game.newImageObject({
	x : 10, y : height - 90,
	file : 'imgs/cycling.png',
	scale : 0.15,
	alpha : 0
});

var tImage = tiles.newImage('imgs/tiles.png');
var anim = tImage.getAnimation(0, 0, 149, 125, 2);

var animCycling = game.newAnimationObject({
	x : 0, y : height - 100,
	w : 50, h : 40,
	animation : anim,
	delay : 50,
	alpha : 0
});

game.newLoop('present', function () {

	if (mouse.isUp('LEFT') || touch.isUp()) {
		game.setLoop('game');
	}

	sky.setAlpha(sky.getAlpha() + 0.005);
	sky.draw();

	logo.moveTime(point(width / 2 - 170 / 2, height / 4), 100);
	logo.setAlpha(logo.getAlpha() + 0.005);
	logo.draw();

	floor.setAlpha(floor.getAlpha() + 0.01);
	floor.moveTime(point(0, height - 100), 50);
	floor.draw();

	sun.moveTime(point(width - 120, 20), 50);
	sun.setAlpha(sun.getAlpha() + 0.01);
	sun.draw();


	if (animCycling.x > width)
		animCycling.x = -100;
	if (floor.getAlpha() > 0.5)
		animCycling.setAlpha(animCycling.getAlpha() + 0.01);
	animCycling.move(v2f(1.2, 0));
	animCycling.draw();

	if (floor.getAlpha() > 0.5)
		tree.setAlpha(tree.getAlpha() + 0.01);
	tree.moveTime(point(width / 2, height - 150), 50);
	tree.draw();


	if (house.getAlpha() > 0.5) {
		if (cycling.x > width)
			cycling.x = -100;
		cycling.move(v2f(1, 0));
		cycling.setAlpha(cycling.getAlpha() + 0.005);
	}
	cycling.draw();

	if (tree.getAlpha() > 0.5) {
		house.setAlpha(house.getAlpha() + 0.05);
		house.moveTime(point(width / 5, height - 150), 20);
	}
	house.draw();




	brush.drawTextLines({
		x : 10, y : 10,
		lines : [
		'PointJS - игровой HTML5 движок.',
		'Для продолжения кликните по сцене'
		],
		color : 'white',
		size : 20,
		style : 'bold italic'
	});

});



gjs.game.setLoop('present');
gjs.game.start();











		// Other ////////////////////////////////////////

		gjs.LURDMove = function (o, s) {
			if (this.keyControl.isDown('RIGHT')) o.move(point(s, 0));
			if (this.keyControl.isDown('LEFT'))  o.move(point(-s, 0));
			if (this.keyControl.isDown('DOWN'))  o.move(point(0, s));
			if (this.keyControl.isDown('UP'))    o.move(point(0, -s));
		};

		gjs.LURDTurnMove = function (o, st, sm) {
			if (this.keyControl.isDown('RIGHT')) o.turn(st);
			if (this.keyControl.isDown('LEFT'))  o.turn(-st);
			if (this.keyControl.isDown('DOWN'))  o.moveAngle(-sm);
			if (this.keyControl.isDown('UP'))    o.moveAngle(sm);
		};

		gjs.LURDTurnMoveA = function (o, st, sm) {
			var ud = 0, tmpST;
			if (!isDef(o.speedLURDTMA)) { o.speedLURDTMA = 0; }

			if (this.keyControl.isDown('DOWN'))  { ud = -1; }
			else if (this.keyControl.isDown('UP')) { ud = 1; }
			else if (this.keyControl.isDown('SPACE')) { o.speedLURDTMA += o.speedLURDTMA > 0 ? -0.1 : 0.1; }
			else { o.speedLURDTMA += o.speedLURDTMA > 0 ? -0.005 : 0.005;  }

			o.speedLURDTMA += (Math.abs(o.speedLURDTMA) < sm) ? (0.01 * ud) : 0;

			if (o.speedLURDTMA != 0) {
				tmpST = st * Math.abs(o.speedLURDTMA / 2);
				if (this.keyControl.isDown('RIGHT')) o.turn( limit(o.speedLURDTMA > 0 ?   tmpST : -tmpST,  st));
				if (this.keyControl.isDown('LEFT'))  o.turn( limit(o.speedLURDTMA > 0 ?  -tmpST :  tmpST,  -st));
			}

			o.moveAngle(o.speedLURDTMA);
		};







		// end Other ////////////////////////////////////