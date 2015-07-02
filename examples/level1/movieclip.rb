#!/usr/bin/ruby
#
# sprite.rb -- IKEGAMI Daisuke
# original is http://ming.sourceforge.net/examples/example.php?name=sprite
# $Log: movieclip.rb,v $
# Revision 1.3  2008/01/20 09:14:53  baribal
# *** empty log message ***
#
#

require 'ming/ming'
include Ming

s = SWFShape.new
s.set_right_fill(s.add_fill(0xff, 0, 0))
s.move_pen_to(-50, -50)
s.draw_line_to(50, -50)
s.draw_line_to(50, 50)
s.draw_line_to(-50, 50)
s.draw_line_to(-50, -50)

p = SWFMovieClip.new
i = p.add(s)

17.times do
  p.next_frame
  i.rotate(5)
end
p.next_frame

m = SWFMovie.new
i = m.add(p)
i.move_to(160,120)

m.set_background(0xff, 0xff, 0xff)
m.set_dimension(320, 240)

m.save('sprite.swf')

