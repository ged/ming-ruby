 
     _root.createEmptyMovieClip("ball", 1);
     _root.ball.lineStyle(80, 0x2FF222, 100);
     _root.ball.moveTo(0, 0);
     _root.ball.lineTo(1, 0);
     _root.ball.onEnterFrame = function()  {
       _root._x -= (_root.ball._x - _root._xmouse) /4;
       _root._y -= (_root.ball._y - _root._ymouse) /4;
       };
       _root.ball.onMouseMove = function() {          
          var col = new Color("ball");
	  var myTransformObject = col.getTransform();
	  myTransformObject.gb = 250;
	  myTransformObject.bb = 250;
          col.setTransform(myTransformObject);
       };
       _root.ball.onMouseDown = function() {          
          var col1 = new Color("ball");
	  var myTransformObject1 = col1.getTransform();
	  myTransformObject1.rb = 20;
	  myTransformObject1.bb = 20;
          col1.setTransform(myTransformObject1);
       };

