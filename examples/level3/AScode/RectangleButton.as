function RectangleButtonClass() {}
RectangleButtonClass.prototype = new MovieClip();
RectangleButtonClass.prototype.init = function(label, col, w, h) {
  w = (w == undefined) ? 100 : w;
  h = (h == undefined) ? 30 : h;
  col = (col == undefined) ? 0xAFAFAF : col;
  label = (label == undefined) ? 'wyslij' : label;
  
  this.createEmptyMovieClip('btn', 1);
  this.createAutoTextField('label', 2);
  this.label.selectable = false;
  this.label.text = label;
  
  w = (this.label._width > w) ? this.label._width + 6 : w;
  
  with (this.btn) {
    lineStyle(0, 0, 0);
    beginFill(col);
    drawRectangle(w, h);
    endFill();
    _x += w/2;
    _y += h/2;
    };
    
  this.label._x = this._width/2 - this.label._width/2;
  this.label._y = this._height/2 - this.label._height/2;
  
  this.btn.onPress = function() {
    this._xscale = 96;
    this._yscale = 96;
    };
  this.btn.onRelease = function() {
    this._xscale = 100;
    this._yscale = 100;
    };
};
Object.registerClass('RectangleButtonSymbol', RectangleButtonClass);