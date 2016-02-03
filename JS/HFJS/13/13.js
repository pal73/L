/**
 * Created by PAL73 on 03.02.16.
 */

function Game() {
    this.level = 0;
}
Game.prototype.play = function() {
// Действия игрока
    this.level++;
    console.log("Welcome to level " + this.level);
    this.unlock();
}
Game.prototype.unlock = function() {
    if (this.level === 4) {
        Robot.prototype.deployLaser = function () {
            console.log(this.name + " is blasting you with laser beams.");
        }
    }
}
function Robot(name, year, owner) {
    this.name = name;
    this.year = year;
    this.owner = owner;
}
var game = new Game();
var robby = new Robot("Robby", 1956, "Dr. Morbius");
var rosie = new Robot("Rosie", 1962, "George Jetson");
while (game.level < 5) {
    game.play();
}
//robby.deployLaser();
//rosie.deployLaser();


