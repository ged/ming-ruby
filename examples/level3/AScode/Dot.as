function drawGrid (theWidth, theHeight) {
  var initDot = new Object();
  var k = 0;
  _root.createEmptyMovieClip('mask', 3);
    for (var i = 0; i < theWidth; i+=10) {
      for (var j = 0; j < theHeight; j+=10) {
        var dotName = 'DotSymbol' + i + '_' + j;
	initDot._x = i;
	initDot._y = j;
	initDot.timer = 1000 + Math.ceil(Math.random()*80000);
	_root.mask.attachMovie('DotSymbol', dotName, k, initDot);
	k++;
	};
  };
};
drawGrid(290, 215);

  _root.createEmptyMovieClip('myImage', 1);
  _root.myImage.createEmptyMovieClip('imageHolder_mc', 1);
  myImage.imageHolder_mc.loadMovie('picture.jpg');
  
  _root.createEmptyMovieClip('myImage1', 2);
  _root.myImage1.createEmptyMovieClip('imageHolder_mc', 1);
  myImage1.imageHolder_mc.loadMovie('backyard1.jpg');

  myImage1.setMask(mask);