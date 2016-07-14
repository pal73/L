/**
 * Created by PAL on 14.07.2016.
 */
var myGame = {
    start: function(){
        Crafty.init(400,300);
        Crafty.background('rgb(249, 3, 125)');

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
                this.x = this.x + 10 * (eventData.dt / 1000);
            });
        console.log("STOPSTARTING");
    }
}