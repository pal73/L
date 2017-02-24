
var pjs = new PointJS('2d', 400, 400,{backgroundColor : '#DCDCDC'});
pjs.system.initFullPage();

var vector = pjs.vector;
var log = pjs.system.log;
var game = pjs.game;
var point = vector.point;
var size = vector.size;
var camera = pjs.camera;
var brush = pjs.brush;
var OOP = pjs.OOP;
var math = pjs.math;

var width = pjs.system.getWH().w;
var height = pjs.system.getWH().h;

//var key = pjs.keyControl;
//key.initKeyControl();

//var mouse = pjs.mouseControl;
//mouse.initMouseControl();

var touch = pjs.touchControl;
touch.initTouchControl();

log(width);
log(height);