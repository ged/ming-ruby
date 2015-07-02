#!/usr/bin/ruby
# Flash 8 displacement - move the mouse
# code by gazb : gazb dot ming at NOSPAM gmail dot com
# March 2007
# http://www16.brinkster.com/gazb/ming/
# Ruby code by Pawel Karwowski pkarwow at fastmail dot fm

require 'ming/ming'
include Ming

set_scale(20.0)
use_SWF_version(8)

@movie = SWFMovie.new
@movie.set_rate(31)
@movie.set_dimension(550,400)
@movie.set_background(0xee,0xdb,0x89)

# create an actionscript string
@strAction="

// create references to classes

ffdm= flash.filters.DisplacementMapFilter;
fdbd= flash.display.BitmapData;
fgp= flash.geom.Point;
fgm= flash.geom.Matrix;
fgct= flash.geom.ColorTransform;

var filteredMc = createDisplacementMapRectangle();

filteredMc._x=50;
filteredMc._y=170;

filteredMc.onPress = function() {
var filter = this.filters[0];
var randomNum = Math.floor(Math.random() * 20);
filter.scaleY = randomNum;
filter.mode = 'color';
filter.alpha =0;
filter.color = 0x00FF00;
this.filters = new Array(filter);
};

function createDisplacementMapRectangle() {

var mapBitmap = createGradientBitmap(450, 80, 0xFF000000, 'radial',true);
var filter = new ffdm(mapBitmap, new fgp(-30, -30), 1, 1, 1, 1, 'wrap', 0x000000, 0x000000);

var txtBlock = createTextBlock();
txtBlock._x = 30;
txtBlock._y = 30;

txtBlock.filters = new Array(filter);

return txtBlock;
};

function createGradientBitmap(w, h, bgColor, type, hide) {
var mc = this.createEmptyMovieClip('mc', 1);
var matrix = new fgm();
matrix.createGradientBox(w, h, 0, 0, 0);

mc.beginGradientFill(type, [0xFF0000, 0x0000FF], [100, 100], [0x55, 0x99], matrix, 'pad');        
mc.lineTo(w, 0);
mc.lineTo(w, h);
mc.lineTo(0, h);
mc.lineTo(0, 0);
mc.endFill();
if(hide) { mc._alpha = 0;}else{ mc._alpha = 100;}

var bmp = new fdbd(w, h, true, bgColor);
bmp.draw(mc, new fgm(), new fgct(), 'normal', bmp.rectangle, true);
mc.attachBitmap(bmp, this.getNextHighestDepth());

return bmp;
};

function createTextBlock() {
var txtBlock = this.createEmptyMovieClip('txtBlock', this.getNextHighestDepth());
txtBlock.createTextField('txt', this.getNextHighestDepth(), 0, 0, 450, 80);
var myformat = new TextFormat();
myformat.font = 'Verdana';
myformat.size = 16;
myformat.bold = true;
txtBlock.txt.setNewTextFormat(myformat);
txtBlock.txt.text = 'watch the text bend with the displacement map';
return txtBlock;
};

"
# write actionscript string to root frame #1
@movie.add(SWFAction.new(@strAction))

@movie.save("displacement.swf",9)
