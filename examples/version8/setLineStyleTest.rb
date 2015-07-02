#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(8)
set_scale(20.00000000)

@m = SWFMovie.new

@ls = SWFLineStyle::set_line_style(40, 25, 0, 0, 128)

@ls1 = SWFLineStyle::set_line_style_2(40, 25, 0, 0, 128, SWFLineStyle::FLAG_HINTING | SWFLineStyle::JOIN_ROUND | 
				 SWFLineStyle::FLAG_ENDCAP_SQUARE, 0)

ObjectSpace.each_object(SWFLineStyle) {|x| p x}

@m.save("setLineStyleTest.swf")
