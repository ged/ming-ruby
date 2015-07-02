#!/usr/bin/ruby
#
# morph2.rb
# Author: Peter Liscovius 2002
#
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2008.27.09
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(7)

@m = SWFMovie.new

@m.set_dimension(400,300)
@m.set_background(0xff,0xff,0xff)
@m.set_rate(15)


### Morph 1 ###
@morph = SWFMorph.new

@s1 = @morph.get_shape1
@s1.set_line(1, 0x00, 0x00, 0x00)
@s1.set_left_fill(@s1.add_fill(0,200,200))
@s1.draw_line(100, 0)
@s1.draw_line(0, 200)
@s1.draw_line(-100, 0)
@s1.draw_line(-100, 0)
@s1.draw_line(0, -200)
@s1.draw_line(100, 0)
#@s1.set_left_fill

@s2 = @morph.get_shape2	
@s2.set_line(5, 0xff, 0x99, 0x00)
@s2.set_left_fill(@s2.add_fill(255,0,0))
@s2.draw_curve(60, -50, 40, 40)
@s2.draw_curve(50,50, -100,60)
@s2.draw_curve(-50,30, 0,40)
@s2.draw_curve(0,-50, -50,-10)
@s2.draw_curve(-100,-30,50,-80)
@s2.draw_curve(40, -60, 60, 60)
#@s2.set_left_fill

@morph_inst = @m.add(@morph);
@morph_inst.move(200,80);

0.step(1, 0.05) do |i|

	@morph_inst.set_ratio(i)  
	@m.next_frame
end

0.step(1, 0.05) do |i|

	@morph_inst.set_ratio(1-i)  
	@m.next_frame
end

@m.save("morph2.swf",9)
