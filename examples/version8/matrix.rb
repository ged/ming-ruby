#!/usr/bin/ruby
# cxform3.rb
# http://www.opaque.net/ming/examples/example.php?name=cxform

require 'ming/ming'
include Ming

use_SWF_version(9)

m = SWFMovie.new
m.set_dimension(600, 400)

s = SWFShape.new

fs = SWFFillStyle.new(255, 0, 0, 255)
s.set_right_fill_style(fs)
s.move_pen_to(0, 0)
s.draw_line(40, 0)
s.draw_line(0, 40)
s.draw_line(-40, 0)
s.draw_line(0, -40)

i = m.add(s)
i.move_to(100, 100)
i.scale_to(2, 3)

matrix = i.get_matrix
@a = matrix.get_scale_x
@b = matrix.get_scale_y
@c = matrix.get_rotate_0
@d = matrix.get_rotate_1
@f = matrix.get_translate_x  
@g = matrix.get_translate_y  

puts @a, @b, @c, @d, @f, @g

m.save("matrix.swf")
