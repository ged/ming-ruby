#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(8)
set_scale(20.00000000)

@m = SWFMovie.new
@m.set_dimension(320, 240)


# first gradient- black to white
@g = SWFGradient.new
@g.set_spread_mode(SWFGradient::REPEAT)
@g.set_interpolation_mode(SWFGradient::LINEAR)



@g.add_entry(0, 0, 0, 0, 255);	
@g.add_entry(0.2, 0, 10, 0, 255);	
@g.add_entry(0.3, 110, 0, 10, 255);	
@g.add_entry(0.4, 20, 0, 0, 255);	
@g.add_entry(0.5, 0, 20, 0, 255);	
@g.add_entry(0.6, 0, 0, 20, 255);	
@g.add_entry(0.7, 30, 0, 0, 255);
@g.add_entry(0.8, 0, 30, 0, 255);	
@g.add_entry(0.9, 0, 0, 30, 255);		


@fillstyle = SWFFillStyle.new(@g, SWFFill::LINEAR_GRADIENT)
@fill = @fillstyle::fill_from_fillstyle
#@fill.move_to(800, 800)

@shape = SWFShape.new
@shape.use_version(SWFShape::SHAPE4)
@shape.set_right_fill(@fill)
	
@shape.set_line(1, 0,0,0,255)
@shape.draw_line(100, 0)
@shape.draw_line(0, 100)
@shape.draw_line(-100, 0)
@shape.draw_line(0, -100)

@m.add(@shape)

@m.save("gradient8a.swf")
