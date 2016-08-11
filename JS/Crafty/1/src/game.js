/**
 * Created by PAL on 14.07.2016.
 */
var myGame = {
    timeCnt: 0,
    timeCntMax: 20,
    mainCnt:123,

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
      /*  var textBox=Crafty.e("2D,Canvas,Color,Text")
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
            .color('#ffffff');*/
        var textBox=Crafty.e('Mytextbox').text(myGame.mainCnt);
        var textBox1=Crafty.e('Mytextbox')
            .attr({
                x:200,
                y:250
            });

        console.log("STOPSTARTING");
        var blackbox = Crafty.e('2D, Canvas, Fourway, Color')
            .attr({x: 100, y: 50, h: 30, w: 30})
            .color('black')
            .fourway(5);
        blackbox.bind('NewDirection',function(){
            myGame.mainCnt++;
            console.log('NEWDIRECTION'+ myGame.mainCnt);
            textBox.text(myGame.mainCnt);
        });
        blackbox.bind('Moved',function(e) {
            myGame.mainCnt++;
            console.log('MOVED' + myGame.mainCnt);
            textBox1.text(e.axis + e.oldValue);
        });
    }
}