
    var GRAVITY = 0.5;
    var FRICTION = 0.995;
    var ELASTICITY = 1.050;
    _root.lineStyle(10, 0x1AA111, 100);
    _root.moveTo(20, 400);
    _root.lineTo(600, 400);

  for (var i = 0; i < 20; i++) {
    var ball = _root.createEmptyMovieClip("ball"+i, i);
    ball.lineStyle(16,0xFF0000,100);
    ball.moveTo(0,-3);
    ball.lineTo(1,-3);
    ball._x = 25 + Math.random() * 550;
    ball._y = Math.random() * 200;

    ball.onEnterFrame =  function() {
    this.speedY += GRAVITY;
    this.speedY *= FRICTION;
    this._y += this.speedY;
    if (this._y > 400) {
      this._y = 400;
      this.speedY = -this.speedY * ELASTICITY;
     }
    };

    ball.onPress =  function() { 
    this.startDrag();
    delete this.onEnterFrame;
    this.onMouseMove = function() {
      updateAfterEvent();
     };
    };

    ball.onRelease = ball.onReleaseOutside = function() {
    this.speedY._y = 0;
    this.stopDrag();
    this.onEnterFrame =  function() {
    this.speedY += GRAVITY;
    this.speedY *= FRICTION;
    this._y += this.speedY;
    if (this._y > 400) {
      this._y = 400;
      this.speedY = -this.speedY * ELASTICITY;
      }
     };
    };

  };
