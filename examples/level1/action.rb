#!/usr/bin/ruby
#
# action.rb -- IKEGAMI Daisuke
# original is http://ming.sourceforge.net/examples/example.php?name=action
# $Log: action.rb,v $
# Revision 1.3  2008/01/20 09:14:53  baribal
# *** empty log message ***
#
#

require 'ming/ming'
include Ming

s = SWFShape.new

f = s.add_fill(0xff, 0, 0)
s.set_right_fill(f)

s.move_pen_to(-25, -25)
s.draw_line_to(25, -25)
s.draw_line_to(25, 25)
s.draw_line_to(-25, 25)
s.draw_line_to(-25, -25)

p = SWFMovieClip.new
i = p.add(s)
i.set_depth(1)
p.next_frame

5.times do
  i.rotate(-15)
  p.next_frame
end

m = SWFMovie.new
m.set_background(0xff, 0xff, 0xff)
m.set_dimension(320, 240)

i = m.add(p)
i.set_depth(1)
i.move_to(-50, 120)
i.set_name('box')

m.add(SWFAction.new("box._x += 3;"))
m.next_frame
m.add(SWFAction.new("prevFrame(); play();"))
m.next_frame

m.save('action.swf')
