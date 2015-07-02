    for (var i =0; i < 250; i++) {
      var star = _root.createEmptyMovieClip('star'+i, i);
      var dot = star.createEmptyMovieClip('dot', 0);
      star._rotation = Math.random() * 360;
      star._x = 350;
      star._y = 250;
      _root.dot.lineStyle(0, 0xFF0000, 100);
      _root.dot.moveTo(0, 10);
      _root.dot.lineTo(0, 15);
      _root.dot.onEnterFrame = function() {
        this._y += this.speed;
	this._yscale += 10;
	this.speed++;
	if(this._y > 500) {
	  this._y = 0;
	  this.speed = Math.random() * 10;
	  this._yscale = 100;
	 }
	};  
      _root.dot.speed = Math.random() * 10;
      };