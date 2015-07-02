#!/usr/bin/ruby
#
# skewxto.rb 
# original is http://www16.brinkster.com
# $Log: skewxto.rb,v $
# Revision 1.1  2007/12/28 13:41:26  baribal
# *** empty log message ***
#
# Revision 1.0  2006/12/25 14:53:00 pawel
# initial commit
#

require 'ming/ming'
include Ming

set_scale(20.0000000);

use_SWF_version(7)
movie = SWFMovie.new
movie.set_dimension(550, 400)
movie.set_background(0xcc, 0xcc, 0xcc)
movie.set_rate(31)

squareshape= SWFShape.new
squareshape.set_right_fill(squareshape.add_fill(255,0,0))
squareshape.move_pen_to(-50,-50)
squareshape.draw_line(100,0)
squareshape.draw_line(0,100)
squareshape.draw_line(-100,0)
squareshape.draw_line(0,-100)

squaresymbol = movie.add(squareshape)
squaresymbol.move_to(250,200)

squaresymbol.skew_x_to(-1)
movie.next_frame()

-1.step(1, 0.05) do |i|
squaresymbol.skew_x_to(i)
movie.next_frame()
end

1.step(-1, -0.05) do |i|
squaresymbol.skew_x_to(i)
movie.next_frame()
end

movie.save("skewxto.swf")
