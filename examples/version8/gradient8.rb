#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(9)
set_scale(1.0)

m = SWFMovie.new
m.set_dimension(320, 240)


g = SWFGradient.new
g.add_entry(0, 0, 0, 0, 255)
g.add_entry(1, 255, 255, 255, 255)

fillstyle =  SWFFillStyle.new(g, SWFFill::LINEAR_GRADIENT)
fill = fillstyle::fill_from_fillstyle
#fill.move_to(16000, 16000)

shape = SWFShape.new
shape.set_right_fill(fill)
	
shape.set_line(1, 0,0,0,255)
shape.draw_line(100, 0)
shape.draw_line(0, 100)
shape.draw_line(-100, 0)
shape.draw_line(0, -100)

m.add(shape)

m.save("gradient8.swf")
