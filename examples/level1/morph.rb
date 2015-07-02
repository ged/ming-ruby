#!/usr/bin/ruby
# morph.rb
# example of Ming for Ruby
# http://opaque.net/ming/examples/morph.html

require 'ming/ming'
include Ming

set_scale(1.0)

p = SWFMorph.new

s = p.get_shape1
s.set_line(0, 0, 0, 0)

s.set_left_fill(s.add_fill(0xff, 0, 0))
s.move_pen_to(-1000, -1000)
s.draw_line(2000, 0)
s.draw_line(0, 2000)
s.draw_line(-2000, 0)
s.draw_line(0, -2000)

s = p.get_shape2
s.set_line(60, 0, 0, 0)

s.set_left_fill(s.add_fill(0, 0, 0xff))
s.move_pen_to(0, -1000)
s.draw_line(1000, 1000)
s.draw_line(-1000, 1000)
s.draw_line(-1000, -1000)
s.draw_line(1000, -1000)

m = SWFMovie.new
m.set_dimension(3000, 2000)
m.set_background(0xff, 0xff, 0xff)

i = m.add(p)
i.move_to(1500, 1000)

r = 0.0
while r <= 1.0
  i.set_ratio(r)
  m.next_frame
  r = r + 0.1
end

m.save('morph.swf')
