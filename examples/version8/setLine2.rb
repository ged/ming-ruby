#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(8)
set_scale(20.00000000)

@m = SWFMovie.new
#@m.set_dimension(320, 240)

@s = SWFShape.new
@s.set_line_2(40, 25, 0, 0, 128, SWFLineStyle::FLAG_HINTING | SWFLineStyle::JOIN_ROUND | 
				 SWFLineStyle::FLAG_ENDCAP_SQUARE, 0)
@s.move_pen_to(25, 25)
@s.draw_line_to(50, 100)
@s.draw_line_to(100, 100)

@m.add(@s)

@m.save("setLine2.swf")
