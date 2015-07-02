#!/usr/bin/ruby
# code by gazb : gazb dot ming at NOSPAM gmail dot com
# March 2006
# http://www16.brinkster.com/gazb/ming/
# ming 0.3 flash 8 BitmapData.pixelDissolve example 
# most f8 AS can be used this way

require 'ming/ming'
include Ming

use_SWF_version(9)

m = SWFMovie.new
m.set_dimension(550,400)
m.set_background(0x33,0x33,0x33)

strAction="
var flashdisplayBitmapData=flash.display.BitmapData;
var flashgeomPoint= flash.geom.Point;

// create first BitmapData object  add perlinNoise pattern
var myBitmapData = new flashdisplayBitmapData(300, 100);
var randomNum = Math.floor(Math.random() * 10);
myBitmapData.perlinNoise(100, 80, 6, randomNum, false, true, 2, false,
null);

// create second BitmapData object  add perlinNoise pattern
var myBitmapData2 = new flashdisplayBitmapData(300, 100);
var randomNum = Math.floor(Math.random() * 10);
myBitmapData2.perlinNoise(100, 80, 6, randomNum, false, false, 4, false,
null);

// atach first BitmapData object to movieclip 
var mc = this.createEmptyMovieClip('mc', this.getNextHighestDepth());
mc.attachBitmap(myBitmapData, this.getNextHighestDepth());
mc._x=(Stage.width-mc._width)/2;mc._y=(Stage.height-mc._height)/2;

// dissolve from first to second BitmapData object onPress
mc.onPress = function() {
    var randomNum = Math.floor(Math.random() * 10);
    dissolve(randomNum);
};

var intervalId;
var totalDissolved = 0;
var totalPixels = myBitmapData.width*myBitmapData.height;
var numPixels = 100;

function dissolve(randomNum) {
    var newNum = myBitmapData.pixelDissolve(myBitmapData2,
myBitmapData2.rectangle, new flashgeomPoint(0, 0), randomNum, numPixels,
0x00FFFF00);
    clearInterval(intervalId);
    if(totalDissolved < totalPixels) {
        intervalId = setInterval(dissolve, 10, newNum);
    }
    totalDissolved += numPixels;
};
"
m.add(SWFAction.new(strAction))

m.save("pixeldissolve.swf",9)
