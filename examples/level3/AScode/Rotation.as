     _root.createEmptyMovieClip("tracker", 0);
     _root.tracker.lineStyle(52, 0xff0000, 50);
     _root.tracker.moveTo(40, 40);
     _root.tracker.lineTo(80, 80);
     _root.tracker._x = Stage.width /2;
     _root.tracker._y = Stage.height /2;
     var RAD_DEG = 180 / Math.PI;
     _root.tracker.onMouseMove = function() {
     var angle = Math.atan2(_root._ymouse - _root._y, _root._xmouse - _root._x);
     this._rotation = angle * RAD_DEG;
     updateAfterEvent();
    };

       
