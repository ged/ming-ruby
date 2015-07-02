#!/usr/bin/ruby

require 'ming/ming'
include Ming

s = SWFShape.new
s.set_right_fill(s.add_fill(0xff, 0, 0))
s.move_pen_to(-500,-500)
s.draw_line_to(500,-500)
s.draw_line_to(500,500)
s.draw_line_to(-500,500)
s.draw_line_to(-500,-500)

p = SWFMovieClip.new
i = p.add(s)

for j in 0...17
  p.next_frame()
  i.rotate(5)
end

p.next_frame()

m = SWFMovie.new
i = m.add(p)
i.move_to(1500,1000)
i.set_name("blah")

m.set_background(0xff, 0xff, 0xff)
m.set_dimension(3000,2000)

m.save("sprite.swf")
