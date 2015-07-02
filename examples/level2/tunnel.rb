#!/usr/bin/ruby
# tunnel.rb -k
# original script on http;//www.redhot.pepper.jp/ming_php
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
#

require 'ming/ming'
include Ming
include Math

set_scale(20.00000)
use_SWF_version(6) # works only with version 6

movie = SWFMovie.new
movie.set_dimension(550, 400)
movie.set_background(0x00,0x00,0x00)
movie.set_rate(31)

def drawOval (x, y, radius, yRadius)
   sh = SWFShape.new
   sh.set_line(3,255,125,0) 
	theta = PI/4
	xrCtrl = radius/cos(theta/2)
	yrCtrl = yRadius/cos(theta/2)
	angle = 0
	sh.move_pen_to(x+radius, y)
	0.upto(8) do |i| 
		angle += theta
		angleMid = angle-(theta/2)
		cx = x+cos(angleMid)*xrCtrl
		cy = y+sin(angleMid)*yrCtrl
		px = x+cos(angle)*radius
		py = y+sin(angle)*yRadius
		sh.draw_curve_to(cx, cy, px, py)
	end
   sh
end


ov1 = drawOval(0,0,80,80)

ringsprite= SWFMovieClip.new
f1 = ringsprite.add(ov1)
ringsprite.next_frame

movie.add_export(ringsprite, "ring")
movie.write_exports

strAction = "
function makering() {
	ring = attachMovie('ring', 'ring' + i, i++);
	ring.num = i;
	ring._x = 100000;
	ring.x = 0;
	ring.y = 0;
	ring.z = 2500;
	ring.xtempo = Math.sin((xwinkel = xwinkel + 0.2)) * 1;
	ring.ytempo = Math.sin((ywinkel = ywinkel + 0.5)) * 1;
	ring.rottempo = (Math.random() * 2) - 1;
	ring.onEnterFrame = ringMove;
};
function ringMove() {
	this.z = this.z - ztempo;
	this.x = this.x + ((270 - _xmouse) * 0.05);
	this.y = this.y + ((200 - _ymouse) * 0.05);
	this.x = this.x + this.xtempo;
	this.y = this.y + this.ytempo;
	this.scale = abstand / (abstand + this.z);
	this._x = (this.x * this.scale) + 270;
	this._y = (this.y * this.scale) + 200;
	this._xscale = (this._yscale = this.scale * 100);
	this._alpha = (2500 - this.z) * 0.1;
	this._rotation = this._rotation + this.rottempo;
	if (this.z < ((-abstand) / 2)) {
		removeMovieClip(this);
	}
};

abstand = 150; //200
ztempo = 30; //25
onEnterFrame = function () {
	if ((getTimer() - start) > 100) {
		start = getTimer();
		makering();
	}
};

"

movie.add(SWFAction.new(strAction))

movie.save("tunnel.swf")
