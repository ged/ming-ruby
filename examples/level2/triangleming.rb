#!/usr/bin/ruby
#
# triangleming.rb 
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006.05.09
#

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(7)

m = SWFMovie.new
m.set_dimension(550,400)
m.set_background(0xcc,0xcc,0xcc)
m.set_rate(12) 

triangleshape = SWFShape.new 
triangleshape.set_line( 5, 128, 128, 0) 
triangleshape.move_pen_to(200,200)
triangleshape.draw_line(100,100) 
triangleshape.draw_line(-200, 0) 
triangleshape.draw_line(100, -100) 

trianglesprite = SWFMovieClip.new
trianglesprite.add(triangleshape)
trianglesprite.next_frame
m.add(triangleshape)

m.save("triangleming.swf")
