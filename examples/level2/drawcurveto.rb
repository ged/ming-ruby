#!/usr/bin/ruby
# drawcurveto test...
# code by gazb : gazb dot ming at NOSPAM gmail dot com
# March 2004
# http://www16.brinkster.com/gazb/ming/

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6)

@movie = SWFMovie.new
@movie.set_dimension(550,400)
@movie.set_background(0xcc,0xcc,0xcc)
@movie.set_rate(12)

0.step(300, 10) do |@i|

  @s = SWFShape.new
  @s.set_line(4, 0, 0, 0)
  @s.set_right_fill(@s.add_fill(255,0,0))
  @s.move_pen_to(10, 10)
  @s.draw_line_to(310, 10)
  @s.draw_line_to(310, 230)
  @s.draw_curve_to(10, @i, 10, 10)
  @movie.add(@s)
  @movie.next_frame()
end

@movie.save("drawcurveto.swf")

