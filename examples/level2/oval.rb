#!/usr/bin/ruby
#
# oval.rb
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl 
# Revision 1.0  2006.05.09
#

require 'ming/ming'
include Ming
include Math

m = SWFMovie.new
m.set_dimension(550,400)
m.set_background(0xcc, 0xcc, 0xcc )

# ming php function based on MovieClip.prototype.drawOval @
# http://todbot.com/ming/tsts/flash6/drawMethods/drawOval.as

def drawOval(x, y, radius, yRadius)
sh = SWFShape.new
sh.set_line(5,0,125,0) 
	theta = PI/4
	xrCtrl = radius/cos(theta/2)
	yrCtrl = yRadius/cos(theta/2)
	angle = 0
	sh.move_pen_to(x+radius, y)
	0.upto(7) do |i|
	 angle += theta
	 angleMid = angle-(theta/2)
	 cx = x+cos(angleMid)*xrCtrl
	 cy = y+sin(angleMid)*yrCtrl
	 px = x+cos(angle)*radius
	 py = y+sin(angle)*yRadius
	 sh.draw_curve_to(cx, cy, px, py)
end
return sh
end

ov1=drawOval(100,100,50,25);
ov2=drawOval(300,100,80,50);
ov3=drawOval(200,300,25,100);
ov4=drawOval(320,300,75,100);

m.add(ov1)
m.add(ov2)
m.add(ov3)
m.add(ov4)

m.save("oval.swf")

