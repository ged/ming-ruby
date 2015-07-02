#!/usr/bin/ruby
#
# skewyto.rb 
# original is http://www16.brinkster.com
# $Log: skewyto.rb,v $
# Revision 1.1  2007/12/28 13:41:26  baribal
# *** empty log message ***
#
# Revision 1.0  2006/12/25 15:38:00 pawel
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
squareshape.move_pen_to(-5,-5)
squareshape.draw_line(20,0)
squareshape.draw_line(0,20)
squareshape.draw_line(-20,0)
squareshape.draw_line(0,-20)

50.step(300, 100) do |j|
  25.step(500, 25) do |i|
    squaresymbol = movie.add(squareshape)
    squaresymbol.move_to(i, j)
    squaresymbol.skew_y_to(i*0.001+j*0.008)
 end
end

movie.save("skewyto.swf")

