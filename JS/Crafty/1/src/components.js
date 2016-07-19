/**
 * Created by PAL on 14.07.2016.
 */
Crafty.c('Mytextbox',{
    init: function(){
        this.requires("2D,Canvas,Color,Text")
            .attr({
                x:200,
                y:200,
                w:40,
                h:40
            })
            .textFont({
                size:'20px'
            })
            //.text('10000')
            .color('#ffffff');
    },
});
