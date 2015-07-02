#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(7)
set_scale(1.0)

m = SWFMovie.new
m.set_dimension(320, 240)

s = SWFShape.new()

# first gradient- black to white
g = SWFGradient.new()
g.add_entry(0.0, 0, 0, 0)
g.add_entry(1.0, 0xff, 0xff, 0xff)

f = s.add_fill(g, SWFFill::LINEAR_GRADIENT)

s.set_right_fill(f)
s.draw_line(320, 0)
s.draw_line(0, 240)
s.draw_line(-320, 0)
s.draw_line(0, -240)

m.add(s)

s = SWFShape.new()

# second gradient- radial gradient from white to red to transparent
g = SWFGradient.new()
g.add_entry(0.0, 0xff, 0, 0, 0xff)
g.add_entry(1.0, 0xff, 0, 0, 0)

f = s.add_fill(g, SWFFill::RADIAL_GRADIENT)

s.set_right_fill(f)
s.draw_line(320, 0)
s.draw_line(0, 240)
s.draw_line(-320, 0)
s.draw_line(0, -240)

m.add(s)

m.save("gradient.swf")

