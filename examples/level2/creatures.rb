#!/usr/bin/ruby
#
# creatures.rb
# original script on http;//www.redhot.pepper.jp/ming_php
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.25
#

require 'ming/ming'
include Ming

use_SWF_version(6) #works only with version 6

set_scale(20.0)
set_cubic_threshold(3)

movie = SWFMovie.new
movie.set_dimension(520,380)
movie.set_rate(31)
movie.set_background(0x90, 0x90, 0x90)


ov1 = SWFShape.new
ov1.set_right_fill(ov1.add_fill(0x00,0x00,0x00,0xff))
ov1.draw_circle(7)
ov1.move_pen_to(0,0) 
ov1.set_right_fill(ov1.add_fill(0x90,0x90,0x90,0xff))
ov1.draw_circle(6)

footsprite= SWFMovieClip.new
f1 = footsprite.add(ov1)
footsprite.next_frame

movie.add_export(footsprite, "foot")
movie.write_exports

ov2 = SWFShape.new
ov2.set_right_fill(ov2.add_fill(0x00,0x00,0x00,0xff))
ov2.draw_circle(14)
ov2.move_pen_to(0,0) 
ov2.set_right_fill(ov2.add_fill(0x90,0x90,0x90,0xff))
ov2.draw_circle(13)

bodysprite= SWFMovieClip.new
f2 = bodysprite.add(ov2)
bodysprite.next_frame

bodyclip=movie.add(bodysprite)
bodyclip.set_name("body_mc")

strAction = "
grav = 0.5;
right = 20;
left = 520;
bottom = 380;
numFeet = 4;
radius = 50;
k = 0.2;
damp = 0.85;
body_mc.onPress = doDrag;
body_mc.onRelease = noDrag;
body_mc.onReleaseOutside = noDrag;
for (i=0; i<numFeet; i++) {
_root.attachMovie('foot', 'foot'+i+'_mc', i);
_root['foot'+i+'_mc']._x = body_mc._x + Math.random()*100-50;
_root['foot'+i+'_mc']._y = body_mc._y + Math.random()*100-50;
_root['foot'+i+'_mc'].onPress = doDrag;
_root['foot'+i+'_mc'].onRelease = noDrag;
_root['foot'+i+'_mc'].onReleaseOutside = noDrag;
_root['foot'+i+'_mc'].onEnterFrame = footSpring;
};
function doDrag() {
this.startDrag();
this.dragging = true;
};
function noDrag() {
stopDrag();
this.dragging = false;
};
body_mc.onEnterFrame = bodySpring;
function footSpring() {
if (!this.dragging) {
var dx = this._x - body_mc._x;
var dy = this._y - body_mc._y;
var angle = Math.atan2(dy, dx);
var targetX = body_mc._x + Math.cos(angle)*radius;
var targetY = body_mc._y + Math.sin(angle)*radius;
this.vx += (targetX-this._x)*k;
this.vy += (targetY-this._y)*k;
this.vy += grav;
this.vx *= damp;
this.vy *= damp;
this._x += this.vx;
this._y += this.vy;
if (this._x > left-this._width/2) {
this._x = left-this._width/2;
this.vx *= -1;
};
if (this._x < right+this._width/2) {
this._x = right+this._width/2;
this.vx *= -1;
};
if (this._y > bottom-this._height/2) {
this._y = bottom-this._height/2;
this.vy *= -1;
}
} else {
this.vx = this._x-this.oldx;
this.vy = this._y-this.oldy;
this.oldx = this._x;
this.oldy = this._y;
}
};
function bodySpring() {
if (!this.dragging) {
for (i=0; i < numFeet; i++) {
var dx = this._x-_root['foot'+i+'_mc']._x;
var dy = this._y-_root['foot'+i+'_mc']._y;
var angle = Math.atan2(dy, dx);
var targetX = _root['foot'+i+'_mc']._x + Math.cos(angle)*radius;
var targetY = _root['foot'+i+'_mc']._y + Math.sin(angle)*radius;
this.vx += (targetX-this._x)*k;
this.vy += (targetY-this._y)*k;
};
this.vy += grav;
this.vx *= damp;
this.vy *= damp;
this._x += this.vx;
this._y += this.vy;
if (this._x > left-this._width/2) {
this._x = left-this._width/2;
this.vx *= -1;
};
if (this._x < right+this._width/2) {
this._x = right+this._width/2;
this.vx *= -1;
};
if (this._y > bottom-this._height/2) {
this._y = bottom-this._height/2;
this.vy *= -1;
}
} else {
this.vx = this._x-this.oldx;
this.vy = this._y-this.oldy;
this.oldx = this._x;
this.oldy = this._y;
}
};

_root.onEnterFrame = function() {
_root.clear();
_root.lineStyle(1, 0x000000, 100);
for (i=0; i < numFeet; i++) { 
_root.moveTo(body_mc._x, body_mc._y);
_root.lineTo(_root['foot'+i+'_mc']._x, _root['foot'+i+'_mc']._y);
};
};
"

movie.add(SWFAction.new(strAction))

movie.save("creatures.swf")
