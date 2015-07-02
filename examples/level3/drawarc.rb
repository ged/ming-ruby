#!/usr/bin/ruby
#
#
# drawarc.rb
# original script by Joey Lott in ActionScript Cookbook.
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.27
#


require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6) # works only with version 6

movie = SWFMovie.new
movie.set_dimension(500,400)
movie.set_background(0xff,0xff,0xff)
movie.set_rate(31)

  f = open("./aa/DrawingMethods.as", "r")
  ary = f.readlines
       as = SWFAction.new(ary.to_s)
       movie.add(as)
  f.close

  g = open("./aa/DrawArc.as", "r")
  ary2 = g.readlines
       as2 = SWFAction.new(ary2.to_s)
       movie.add(as2)
  g.close

action = SWFAction.new("

 _root.onEnterFrame = function()
 {
         _root.clear();
         _root.lineStyle(2,0xff0000, 200);
	 _root.beginFill(0xff0000);

	 _root.moveTo(220, 220);
         drawArc(220, 220, 90, 145, 200);
	 
	 drawEllipse(50,80, 100, 100);
	 drawEllipse(50,50, 400, 100);
	 drawRegularPolygon(8, 50, 30, 250, 80);
	 drawRegularPolygon(3, 110, 120, 150, 280);
	 drawRegularPolygon(4, 90, 350, 440, 310);
};
")

movie.add(action)
movie.save("drawarc.swf")

