/**
 * Created by PAL on 14.07.2016.
 */
var myGame = {
    timeCnt: 0,
    timeCntMax: 20,

    start: function(){
        Crafty.init(400,300,"game_body");
        Crafty.background('rgb(249, 3, 125)');
        var myText = Crafty.e('2D, DOM, Color, Text')
            .attr({
                x: 20,
                y: 20
            })
            .textColor('green')
            .textFont({
                size: '20px'
            });
        myText.text("Hello!!!");
        var mife = Crafty.e("2D,Canvas,Color")
            .attr({
                x:20,
                y:30,
                w:10,
                h:10
            })
            .color('#333')
            .bind("EnterFrame", function(eventData) {
                // Move to the right by 10 pixels per second
                //this.x = this.x + 10 * (eventData.dt / 1000);
                myGame.timeCnt += eventData.dt;
                if (myGame.timeCnt >= myGame.timeCntMax) {
                    myGame.timeCnt = 0;
                    this.x += 1;
                    var now = new Date();
                    myText.text(now.getSeconds());
                //this.x = this.x + 10;
                }
            });
        var textBox=Crafty.e("2D,Canvas,Color,Text")
            .attr({
                x:100,
                y:100,
                w:40,
                h:40
            })
            //.textFont({
               // size:'20px'
            //})
            //.text('10000')
            .color('#ffffff');
        console.log("STOPSTARTING");
    }
}