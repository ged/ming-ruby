#!/usr/bin/ruby
# zoom.rb -k
# original script on http;//www.redhot.pepper.jp/ming_php
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
#

require 'ming/ming'
include Ming

set_scale(20.000000)
use_SWF_version(7)

movie = SWFMovie.new

movie.set_dimension(400, 398)
movie.set_background(0x00,0x00,0x00)
movie.set_rate(31)

bitmapshape = SWFBitmap.new("../common/backyard1.jpg")
bitmapsprite= SWFMovieClip.new
fA = bitmapsprite.add(bitmapshape)
bitmapclip=movie.add(bitmapsprite)
bitmapclip.set_name("figureA")

fB = bitmapsprite.add(bitmapshape)
bitmapclip=movie.add(bitmapsprite)
bitmapclip.set_name("figureB")

fB = bitmapsprite.add(bitmapshape)
bitmapsprite.next_frame
bitmapclip=movie.add(bitmapsprite)
bitmapclip.set_name("figureC")

strAction = "
createEmptyMovieClip('picxmms',-500);
picxmms._x=0;
picxmms._y=0;
picxmms.loadMovie('cmisc054.jpg');
";
movie.add(SWFAction.new(strAction))

strAction = "
origin = new Object();
origin.x = 70; //150
origin.y = 70; //150
focalLength = 300;
figureA.x = -300;
figureA.y = 0; 
figureA.z = 0;
figureA.dir = 1;
figureB.x = 0;
figureB.y = 0;
figureB.z = 150;
figureB.dir = 1;
figureC.x = 350;
figureC.y = 0;
figureC.z = 500;
figureC.dir = 1;
speed = 20;

backAndForth = function(){
	this.z += speed*this.dir;
	if (this.z > 500){
		this.z = 500;
		this.dir = -1;
	}else if (this.z < 0){
		this.z = 0;
		this.dir = 1;
	}
	var scaleRatio = focalLength/(focalLength + this.z);
	this._x = origin.x + this.x * scaleRatio;
	this._y = origin.y + this.y * scaleRatio;
	this._xscale = this._yscale = 100 * scaleRatio;
	this.swapDepths(-this.z);
};
figureA.onEnterFrame = backAndForth;
figureB.onEnterFrame = backAndForth;
figureC.onEnterFrame = backAndForth;
";
movie.add(SWFAction.new(strAction))

movie.save("zoom.swf")
