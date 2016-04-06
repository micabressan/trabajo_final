var $player = $('.player');

var $object = $('.object');
var $posObject = $object.position();

var player = {

    UP: 87,
    LEFT: 65,
    DOWN: 83,
    RIGHT: 68,

    sUP: 'up',
    sLEFT: 'left',
    sDOWN: 'down',
    sRIGHT: 'right',

    speed: 128

};

var keysDown = {};
var w = window;
var RAF = w.requestAnimationFrame
    || w.webkitRequestAnimationFrame
    || w.msRequestAnimationFrame
    || w.mozRequestAnimationFrame;


addEventListener("keydown", function (e) {
    console.log(e.keyCode);
    this.keysDown[e.keyCode] = true;
}, false);

addEventListener("keyup", function (e) {
    delete this.keysDown[e.keyCode];
}, false);


var game = {

    current: {
        side: 'left'
    },

    main: function () {
        var now = Date.now();
        var delta = now - then;

        game.update(delta / 1000);

        then = now;

        RAF(game.main);
    },

    getPosition: function () {
        return {
            x: $player.position().left,
            y: $player.position().top
        }
    },

    fire: function () {
        var div = document.createElement('div');
        $(div).css({
            position: 'absolute',
            zIndex: 10,
            backgroundColor: 'black'
        });

        switch (this.current.side) {
            case player.sUP:

                $(div).css({
                    left: this.getPosition().y + 50,
                    top: this.getPosition().x + 50,
                    height: '60px',
                    width: '5px'
                });

                $player.after(div);

                $(div).animate({
                    top: $posObject.top - 50,
                    left: this.getPosition().x + 50
                }, {
                    duration: 1000,
                    step: function( now, fx ){
                    }
                });
                break;

            case player.sLEFT:
                $(div).css({
                    left: this.getPosition().y + 50,
                    top: this.getPosition().x + 50,
                    height: '5px',
                    width: '60px'
                });

                $player.after(div);

                $(div).animate({
                    left: $posObject.left
                }, {
                    duration: 1000,
                    step: function( now, fx ){
                    }
                });

                /*var fps = 15;

                function step() {
                    setTimeout(function () {
                        requestAnimationFrame(step);
                        $(div).css({
                           left: '+=1'
                        });
                    }, 1000 / fps);
                }

                step();*/
                break;
            case player.sRIGHT:
                $player.after(div);
                console.log(this.current.side);

                $(div).animate({
                    left: $posObject.left - 50
                }, {
                    duration: 1000,
                    step: function( now, fx ){
                    }
                });
                break;
            case player.sDOWN:
                $player.after(div);
                console.log(this.current.side);

                $(div).animate({
                    left: $posObject.left - 50
                }, {
                    duration: 1000,
                    step: function( now, fx ){
                    }
                });
                break;
        }
    },

    update: function (modifier) {

        if (32 in keysDown) {
            this.fire();
        }

        // стены
        if (this.getPosition().y <= 5) {
            $player.css({
                top: 10 + 'px'
            });
        } else if (this.getPosition().x <= 5) {
            $player.css({
                left: 10 + 'px'
            });
        }

        if (16 in keysDown) {
            player.speed = 32;
        } else {
            player.speed = 256;
        }

        if ((38 in keysDown) || (player.UP in keysDown)) { // Player holding up
            this.current.side = player.sUP;
            $player.css({
                top: '-=' + player.speed * modifier
            });
        }
        if ((40 in keysDown) || (player.DOWN in keysDown)) { // Player holding down
            this.current.side = player.sDOWN;
            $player.css({
                top: '+=' + player.speed * modifier
            });
        }
        if ((37 in keysDown) || (player.LEFT in keysDown)) { // Player holding left
            this.current.side = player.sLEFT;
            $player.css({
                left: '-=' + player.speed * modifier
            });
        }
        if ((39 in keysDown) || (player.RIGHT in keysDown)) { // Player holding right
            this.current.side = player.sRIGHT;
            $player.css({
                left: '+=' + player.speed * modifier
            });
        }

        if (
            this.getPosition().x <= ($posObject.left + 100)
            && $posObject.left <= (this.getPosition().x + 100)
            && this.getPosition().y <= ($posObject.top + 100)
            && $posObject.top <= (this.getPosition().y + 100)
        ) {
            $object.css({
                'border': '5px solid red'
            });
        } else {
            $object.css({
                'border': '0 solid darkblue'
            });
        }
    }
};

var then = Date.now();

game.main();