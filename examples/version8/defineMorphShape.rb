#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(8)
set_scale(20.00000000)

@m = SWFMovie.new
#@m.set_dimension(320, 240)

@morph = SWFMorph.new

@shape1 = @morph.get_shape1
@shape2 = @morph.get_shape2

@shape1.set_line(4, 25, 0, 0, 128)
@shape1.move_pen_to(5, 5)
@shape1.draw_line_to(50, 30)

@shape2.set_line(4, 25, 0, 0, 128)
@shape2.move_pen_to(5, 5)
@shape2.draw_line_to(50, 130)


@item = @m.add(@morph)

(10).times do | i |
  @item.set_ratio(0.1 * i)
  @m.next_frame
end

@m.save("defineMorphShape.swf")
