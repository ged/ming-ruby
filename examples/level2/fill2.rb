#!/usr/bin/ruby
# fill2.rb -k
# http://ming.sourceforge.net/examples/example.php?name=alphafill

require 'ming/ming'
include Ming

use_SWF_version(7)

c = SWFShape.new

g = SWFGradient.new
g.add_entry(0.0, 0xff, 0xff, 0, 0x88)
g.add_entry(1.0, 0xff, 0, 0, 0x88)

c.set_right_fill(c.add_fill(g, SWFFill::RADIAL_GRADIENT))

c.move_pen_to(10,10)

c.set_line(1,0,0,0)

c.draw_line(540, 0)
c.draw_line(0, 140)
c.draw_line(-540, 0)
c.draw_line(0, -140)

c.move_pen_to(250,250)
c.draw_circle(50)


m = SWFMovie.new
m.set_dimension(600,400)
m.set_background(0xcc, 0xcc, 0xcc)

m.add(c)

m.save("fill2.swf")

