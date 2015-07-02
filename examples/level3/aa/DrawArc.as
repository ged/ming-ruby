/*-------------------------------------------------------------
	mc.drawArc is a method for drawing regular and eliptical 
	arc segments. This method replaces one I originally 
	released to the Flash MX beta group titled arcTo and contains
	several optimizations based on input from the following 
	people: Robert Penner, Eric Mueller and Michael Hurwicz.
-------------------------------------------------------------*/
MovieClip.prototype.drawArc = function(x, y, radius, arc, startAngle, yRadius) {
	// ==============
	// mc.drawArc() - by Ric Ewing (ric@formequalsfunction.com) - v 1.5 - 4.7.2002
	// 
	// x, y = This must be the current pen position... other values will look bad
	// radius = radius of Arc. If [optional] yRadius is defined, then r is 
  //        the x radius
	// arc = sweep of the arc. Negative values draw clockwise.
	// startAngle = starting angle in degrees.
	// yRadius = [optional] y radius of arc. Thanks to Robert Penner for the idea.
	// ==============
	// Thanks to: Robert Penner, Eric Mueller and Michael Hurwicz for their cont
	// ==============
	if (arguments.length<5) {
		return;
	}
	// if yRadius is undefined, yRadius = radius
	if (yRadius == undefined) {
		yRadius = radius;
	}
	// Init vars
	var segAngle, theta, angle, angleMid, segs, ax, ay, bx, by, cx, cy;
	// no sense in drawing more than is needed :)
	if (Math.abs(arc)>360) {
		arc = 360;
	}
	// Flash uses 8 segments per circle, to match that, we draw in a maximum
	// of 45 degree segments. First we calculate how many segments are needed
	// for our arc.
	segs = Math.ceil(Math.abs(arc)/45);
	// Now calculate the sweep of each segment
	segAngle = arc/segs;
	// The math requires radians rather than degrees. To convert from degrees
	// use the formula (degrees/180)*Math.PI to get radians. 
	theta = -(segAngle/180)*Math.PI;
	// convert angle startAngle to radians
	angle = -(startAngle/180)*Math.PI;
	// find our starting points (ax,ay) relative to the secified x,y
	ax = x-Math.cos(angle)*radius;
	ay = y-Math.sin(angle)*yRadius;
	// if our arc is larger than 45 degrees, draw as 45 degree segments
	// so that we match Flashs native circle routines.
	if (segs>0) {
		// Loop for drawing arc segments
		for (var i = 0; i<segs; i++) {
			// increment our angle
			angle += theta;
			// find the angle halfway between the last angle and the new
			angleMid = angle-(theta/2);
			// calculate our end point
			bx = ax+Math.cos(angle)*radius;
			by = ay+Math.sin(angle)*yRadius;
			// calculate our control point
			cx = ax+Math.cos(angleMid)*(radius/Math.cos(theta/2));
			cy = ay+Math.sin(angleMid)*(yRadius/Math.cos(theta/2));
			// draw the arc segment
			this.curveTo(cx, cy, bx, by);
		}
	}
	// In the native draw methods the user must specify the end point
	// which means that they always know where they are ending at, but
	// here the endpoint is unknown unless the user calculates it on their 
	// own. Lets be nice and let save them the hassle by passing it back. 
  endpoint = { x:bx, y:by } ;
	return endpoint;
};
