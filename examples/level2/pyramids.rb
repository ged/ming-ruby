#!/usr/bin/ruby
#
# pyramids.rb
# original script on http;//www.redhot.pepper.jp/ming_php
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.26
#

require 'ming/ming'
include Ming

use_SWF_version(6)

set_scale(20.0)
m = SWFMovie.new
m.set_dimension(300,300)
m.set_rate(30)
m.set_background(0xff, 0xff, 0xff)

strAction = "
this.createEmptyMovieClip('scene1', 1);
scene1._x = 80;
scene1._y = 150;

this.createEmptyMovieClip('scene2', 2);
scene2._x = 220;
scene2._y = 150;
focalLength = 300;

isVisibleBetween = function (a, b, c) {
	if (((b._y-a._y)/(b._x-a._x)-(c._y-a._y)/(c._x-a._x)<0) ^ (a._x<=b._x ==
a._x>c._x)) {
		return true;
	} else {
		return false;
	}
};

make3DPoint = function(x,y,z){
	var point = new Object();
	point.x = x;
	point.y = y;
	point.z = z;
	return point;
};

Transform3DPointsTo2DPoints = function(points, axisRotations){
	var TransformedPointsArray = [];
	var sx = Math.sin(axisRotations.x);
	var cx = Math.cos(axisRotations.x);
	var sy = Math.sin(axisRotations.y);
	var cy = Math.cos(axisRotations.y);
	var sz = Math.sin(axisRotations.z);
	var cz = Math.cos(axisRotations.z);
	var x,y,z, xy,xz, yx,yz, zx,zy, scaleFactor;

	var i = points.length;
	while (i--){
		x = points[i].x;
		y = points[i].y;
		z = points[i].z;

		// rotation around x
		xy = cx*y - sx*z;
		xz = sx*y + cx*z;
		// rotation around y
		yz = cy*xz - sy*x;
		yx = sy*xz + cy*x;
		// rotation around z
		zx = cz*yx - sz*xy;
		zy = sz*yx + cz*xy;
		
		scaleFactor = focalLength/(focalLength + yz);
		x = zx*scaleFactor;
		y = zy*scaleFactor;
		z = -yz;
		TransformedPointsArray[i] = make3DPoint(x, y, z);
	}
	return TransformedPointsArray;
};

pointsArray = [
	make3DPoint(-50,29,29),
	make3DPoint(0,29,-58),
	make3DPoint(50,29,29),
	make3DPoint(0,-58,0)
];

scene1.pyramidAxisRotations = make3DPoint(0,0,0);
scene1.createEmptyMovieClip('face1',1);
scene1.createEmptyMovieClip('face2',2);
scene1.createEmptyMovieClip('face3',3);
scene1.createEmptyMovieClip('face4',4);

rotatePyramid3 = function(){
	this.pyramidAxisRotations.y -= this._xmouse/2000;
	this.pyramidAxisRotations.x += this._ymouse/2000;
	
	var pts2D = Transform3DPointsTo2DPoints(pointsArray,
this.pyramidAxisRotations);
	var mouseIsDown = Key.isDown(1);

	with(this.face1){
		clear();
		lineStyle(2,0x000000,100);
		if (!mouseIsDown) beginFill(0x800000, 100);
		moveTo(pts2D[0].x, pts2D[0].y);
		lineTo(pts2D[1].x, pts2D[1].y);
		lineTo(pts2D[2].x, pts2D[2].y);
		lineTo(pts2D[0].x, pts2D[0].y);
		endFill();
		swapDepths((pts2D[0].z+pts2D[1].z+pts2D[2].z)/3);
	}
	with(this.face2){
		clear();
		lineStyle(2,0x000000,100);
		if (!mouseIsDown) beginFill(0x008000, 100);
		moveTo(pts2D[0].x, pts2D[0].y);
		lineTo(pts2D[1].x, pts2D[1].y);
		lineTo(pts2D[3].x, pts2D[3].y);
		lineTo(pts2D[0].x, pts2D[0].y);
		endFill();
		swapDepths((pts2D[0].z+pts2D[1].z+pts2D[3].z)/3);
	}
	with(this.face3){
		clear();
		lineStyle(2,0x000000,100);
		if (!mouseIsDown) beginFill(0x000080, 100);
		moveTo(pts2D[1].x, pts2D[1].y);
		lineTo(pts2D[2].x, pts2D[2].y);
		lineTo(pts2D[3].x, pts2D[3].y);
		lineTo(pts2D[1].x, pts2D[1].y);
		endFill();
		swapDepths((pts2D[1].z+pts2D[2].z+pts2D[3].z)/3);
	}
	with(this.face4){
		clear();
		lineStyle(2,0x000000,100);
		if (!mouseIsDown) beginFill(0x808000, 100);
		moveTo(pts2D[2].x, pts2D[2].y);
		lineTo(pts2D[0].x, pts2D[0].y);
		lineTo(pts2D[3].x, pts2D[3].y);
		lineTo(pts2D[2].x, pts2D[2].y);
		endFill();
		swapDepths((pts2D[2].z+pts2D[0].z+pts2D[3].z)/3);
	}
};

scene1.onEnterFrame = rotatePyramid3;//1

scene2.pyramidAxisRotations = make3DPoint(0,0,0);
scene2.createEmptyMovieClip('face1',1);
scene2.createEmptyMovieClip('face2',2);
scene2.createEmptyMovieClip('face3',3);
scene2.createEmptyMovieClip('face4',4);

rotatePyramid2 = function(){
	this.pyramidAxisRotations.y -= this._xmouse/2000;
	this.pyramidAxisRotations.x += this._ymouse/2000;
	
	var pts2D = Transform3DPointsTo2DPoints(pointsArray,
this.pyramidAxisRotations);
	var mouseIsDown = Key.isDown(1);

	with(this.face1){
		clear();
		lineStyle(2,0x000000,100);
		if (!mouseIsDown) beginFill(0x800000, 100);
		moveTo(pts2D[0].x, pts2D[0].y);
		lineTo(pts2D[1].x, pts2D[1].y);
		lineTo(pts2D[2].x, pts2D[2].y);
		lineTo(pts2D[0].x, pts2D[0].y);
		endFill();
		swapDepths((pts2D[0].z+pts2D[1].z+pts2D[2].z)/3);
	}
	with(this.face2){
		clear();
		lineStyle(2,0x000000,100);
		if (!mouseIsDown) beginFill(0x008000, 100);
		moveTo(pts2D[0].x, pts2D[0].y);
		lineTo(pts2D[1].x, pts2D[1].y);
		lineTo(pts2D[3].x, pts2D[3].y);
		lineTo(pts2D[0].x, pts2D[0].y);
		endFill();
		swapDepths((pts2D[0].z+pts2D[1].z+pts2D[3].z)/3);
	}
	with(this.face3){
		clear();
		lineStyle(2,0x000000,100);
		if (!mouseIsDown) beginFill(0x000080, 100);
		moveTo(pts2D[1].x, pts2D[1].y);
		lineTo(pts2D[2].x, pts2D[2].y);
		lineTo(pts2D[3].x, pts2D[3].y);
		lineTo(pts2D[1].x, pts2D[1].y);
		endFill();
		swapDepths((pts2D[1].z+pts2D[2].z+pts2D[3].z)/3);
	}
	with(this.face4){
		clear();
		lineStyle(2,0x000000,100);
		if (!mouseIsDown) beginFill(0x808000, 100);
		moveTo(pts2D[2].x, pts2D[2].y);
		lineTo(pts2D[0].x, pts2D[0].y);
		lineTo(pts2D[3].x, pts2D[3].y);
		lineTo(pts2D[2].x, pts2D[2].y);
		endFill();
		swapDepths((pts2D[2].z+pts2D[0].z+pts2D[3].z)/3);
	}
};
scene2.onEnterFrame = rotatePyramid2;
"

m.add(SWFAction.new(strAction))
m.save("pyramids.swf")
