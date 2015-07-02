function loadData() {
  var myXML = new XML();
  myXML.ignoreWhite = true;
  myXML.load('circles.xml');
  myXML.onLoad = function() {
    var bounceAreaWidth = this.firstChild.firstChild.attributes.width;
    var bounceAreaHeight = this.firstChild.firstChild.attributes.height;
    var circlesInfo = new Array();
    var circlesNodes = this.firstChild.lastChild.childNodes;
    var atr;
    for (var i = 0; i < circlesNodes.length; i++) {
      circlesInfo.push(circlesNodes[i].attributes);
    }
    _root.initCircles(bounceAreaWidth, bounceAreaHeight, circlesInfo);
    _root.initButtons();
    _root.createTable();
    };
};
function initCircles(baW, baH, circlesInfo) {
   circles = new Array();
  _root.createEmptyMovieClip("circleHolder", _root.getNewDepth());
  var cInfo;
  for (var i = 0; i < circlesInfo.length; i++) {
    cInfo = circlesInfo[i];
    cir = _root.circleHolder.attachMovie('CircleSymbol', 'circle' + i, i);
    cir.init(0, 0, baW, baH, cInfo.vel, cInfo.col, cInfo.radius);
    cir.setCircleArray(circles);
    circles.push(cir);
  };
  circleHolder.createEmptyMovieClip('border', i);
    with (circleHolder.border) {
      lineStyle(0, 0, 100);
      drawRectangle(baW, baH, 0, 0 , baW/2, baH/2);
  }
  circleHolder.onEnterFrame = function() {
    var vel = 5;
    switch (this.action) {
      case 'up':
        this._y -= vel;
	break;
      case 'down':
        this._y += vel;
	break;
      case 'left':
        this._x -= vel;
	break;
      case 'right':
        this._x += vel;
	break;
      case 'rotateCW':
        this._rotation += vel;
	break;
      case 'rotateCCW':
        this._rotation -= vel;
	break;
      case 'scaleUp':
        this._xscale += vel;
	this._yscale += vel;
	break;
      case 'scaleDown':
        this._xscale -= vel;
	this._yscale -= vel;
      }
   };
};
function initButtons() {
  btnNamesAr = new Array('left', 'right', 'up', 'down', 'scaleUp', 'scaleDown',
                         'rotateCW', 'rotateCCW');
  btnLabelsAr = new Array('left', 'right', 'up', 'down', 'scaleUp',
                          'scaleDown', 'rotateCW', 'rotateCCW');

  for (var i = 0; i < btnNamesAr.length; i++) {
    btn = _root.attachMovie('RectangleButtonSymbol', btnNamesAr[i] + 'Btn', _root.getNewDepth());
    btn.init(btnLabelsAr[i]);
    btn.action = btnNamesAr[i];
    btn.onPress = pressBtn;
    btn.onRelease = releaseBtn;
    btn.onReleaseOutside = btn.onRelease;
    }
    };
function pressBtn() {
  _root.circleHolder.action = this.action;
this.btn.onPress();
};
function releaseBtn() {
  _root.circleHolder.action = null;
  this.btn.onRelease();
};
function createTable() {
  tr0 = new TableRow(5, new TableColumn(5, circleHolder));
  tr1 = new TableRow(5, new TableColumn(5, leftBtn, rightBtn, upBtn, downBtn),
                     new TableColumn(5, scaleUpBtn, scaleDownBtn),
		     new TableColumn(5, rotateCWBtn, rotateCCWBtn));
  t = new Table(5, 0, 0, tr0, tr1);
};
loadData();
