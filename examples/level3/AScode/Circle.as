function CircleClass() {}
CircleClass.prototype = new MovieClip();
CircleClass.prototype.init = function(minX, minY, maxX, maxY, vel,col, radius) {
with (this) {
  lineStyle(0, 0, 0);
  beginFill(0, 100);
  drawCircle(radius);
  endFill();
  }
this.minX = minX;
this.minY = minY;
this.maxX = maxX;
this.maxY = maxY;

this._x = Math.random() * this.maxX;
this._y = Math.random() * this.maxY;
if (vel == "random") {
  this.vel = Math.random() * 6 +3;
} else {
  this.vel = vel;
  }
this.dir = Math.random() * Math.PI *2;
colObj = new Color(this);
if (col == "random") {
  col = Math.random() * 255 * 255 * 255;
  }
colObj.SetRGB(col);
};
CircleClass.prototype.setCircleArray = function (cirAr) {
  this.circleArray = cirAr;
};
CircleClass.prototype.onEnterFrame = function() {
  this._x += Math.cos(this.dir) * this.vel;
  this._y += Math.sin(this.dir) * this.vel;
  if ((this._x + this._width/2) >= this.maxX) {
  this._x = this.maxX - this._width/2-1;
  this.dir += 2 * (Math.PI/2 -this.dir);
  }
  else if ((this._x - this._width/2) <= this.minX) {
  this._x = this.minX + this._width/2 + 1;
  this.dir += 2 * (Math.PI/2 - this.dir);
  }
  if ((this._y + this._height/2) >= this.maxY) {
  this._y = this.maxY - this._height/2 - 1;
  this.dir -= 2 * this.dir;
  }
  else   if ((this._y - this._height/2) <= this.minY) {
  this._y = this.minY + this._height/2 + 1;
  this.dir -= 2 * this.dir;
  }
  for (var i = 0; i < this.circleArray.length; i++) {
  cirB = this.circleArray[i];
  var dx = Math.abs(this._x - cirB._x);
  var dy = Math.abs(this._y - cirB._y);
  var dist = Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
  if (dist <= (this._width/2 + cirB._width/2) && cirB != this) {
    var circlesAngle = Math.atan2(this._y - cirB._y, this._x - cirB._x) + Math.PI/2;
    this.dir = (circlesAngle + this.dir)/2;
    cirB.dir = (-circlesAngle + cirB.dir)/2;
    }
  }
};
Object.registerClass('CircleSymbol', CircleClass);
