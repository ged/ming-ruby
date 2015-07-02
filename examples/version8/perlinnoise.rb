#!/usr/bin/ruby
# Flash 8 perlin - click on the boxes
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
@movie.set_background(0x33, 0x33, 0x33)

# create an actionscript string
@strAction= "
boxwidth=200;
boxheight=200;

// create references to classes
fdb=flash.display.BitmapData;
fgp=flash.geom.Point;

points = [];
points.push(new Point(50, 50));
points.push(new Point(0, 0));
points.push(new Point(30, 0));
points.push(new Point(10, 70));
points.push(new Point(20, 0));
points.push(new Point(0, 20));


var fdb1 = new fdb(boxwidth, boxheight, false, 0x00CCCCCC);
var fdb2 = new fdb(boxwidth, boxheight, false, 0x00FF0000);

// grey
var mc1 = this.createEmptyMovieClip('mc1', this.getNextHighestDepth());
mc1.attachBitmap(fdb1, this.getNextHighestDepth());
mc1._x=Stage.width/2-boxwidth;

mc1._y=Stage.height/2-boxheight/2;

// color
var mc2 = this.createEmptyMovieClip('mc2', this.getNextHighestDepth());
mc2.attachBitmap(fdb2, this.getNextHighestDepth());
mc2._x = Stage.width/2;
mc2._y=Stage.height/2-boxheight/2;

// grey
mc1.onPress = function() {
    var randomNum = Math.floor(Math.random() * 10);
        fdb1.perlinNoise(200, 200, 6, randomNum, false, true, 1, true, null);
};
// color
mc2.onPress = function() {
    var randomNum = Math.floor(Math.random() * 10);
        fdb2.perlinNoise(200, 200, 4, randomNum, false, false, 15, false, points);	
	
};

"

# write actionscript string to root frame #1
@movie.add(SWFAction.new(@strAction))

@movie.save("perlinnoise.swf",9)
