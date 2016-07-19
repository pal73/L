
// An "Actor" is an entity that is drawn in 2D on canvas
//  via our logical coordinate grid
Crafty.c('Actor', {
    init: function() {
        this.requires('2D, Canvas, Grid');
    },
});

// A Tree is just an Actor with a certain color
Crafty.c('Tree', {
    init: function() {
        this.requires('Actor, Color, Solid')
            .color('rgb(20, 125, 40)');
    },
});

// A Bush is just an Actor with a certain color
Crafty.c('Bush', {
    init: function() {
        this.requires('Actor, Color, Solid')
            .color('rgb(20, 185, 40)');
    },
});

// This is the player-controlled character
Crafty.c('PlayerCharacter', {
    init: function() {
        this.requires('Actor, Fourway, Color, Collision')
            .fourway(4)
            .color('rgb(20, 75, 40)')
            .stopOnSolids()
            // Whenever the PC touches a village, respond to the event
            .onHit('Village', this.visitVillage);
    },

    // Registers a stop-movement function to be called when
    //  this entity hits an entity with the "Solid" component
    stopOnSolids: function() {
        // ...
    },

    // Stops the movement
    stopMovement: function() {
        // ...
    },

    // Respond to this player visiting a village
    visitVillage: function(data) {
        villlage = data[0].obj;
        villlage.collect();
    }
});

// A village is a tile on the grid that the PC must visit in order to win the game
Crafty.c('Village', {
    init: function() {
        this.requires('Actor, Color')
            .color('rgb(170, 125, 40)');
    },

    collect: function() {
        this.destroy();
    }
});