#!/usr/bin/ruby
#
# duplicate.rb
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006.05.07 
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6) #works only with version(6)

m= SWFMovie.new
m.set_dimension(550,400)
m.set_background(0xcc,0xcc,0xcc)
m.set_rate(12) 

squareshape= SWFShape.new 
squareshape.set_right_fill(squareshape.add_fill(255,0,0))
squareshape.move_pen_to(-50,-50)
squareshape.draw_line(100,0)
squareshape.draw_line(0,100) 
squareshape.draw_line(-100,0) 
squareshape.draw_line(0,-100) 

squareSprite= SWFMovieClip.new
f2 = squareSprite.add(squareshape)
squareSprite.next_frame()

ss=m.add(squareSprite)
ss.move_to(100,100)
ss.set_name("mc")

strAction="
mc.duplicateMovieClip('mc1',5);
mc1._x=250;
mc1._y=100;
col = new Color(mc1);
col.setRGB(0xFF6600);
";

m.add(SWFAction.new(strAction))
m.save("duplicate.swf");
