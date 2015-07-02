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

puts "Matrix data for DisplayItem i:"
puts
puts @a, @b, @c, @d, @f, @g
puts

position = matrix.position_from_matrix
position.skew_x(2.0)
position.scale(2.0, 2.0)
position.rotate_to(45)
matrix2 = position.get_matrix(position)

@k = matrix2.get_scale_x
@l = matrix2.get_scale_y
@m = matrix2.get_rotate_0
@n = matrix2.get_rotate_1
@o = matrix2.get_translate_x  
@p = matrix2.get_translate_y  

puts "Matrix data after change:"
puts
puts @k, @l, @m, @n, @o, @p
puts

position.set_matrix(1,0,0,1,1.85,-0.30)
matrix3 = position.get_matrix(position)

@r = matrix3.get_scale_x
@s = matrix3.get_scale_y
@t = matrix3.get_rotate_0
@x = matrix3.get_rotate_1
@y = matrix3.get_translate_x  
@z = matrix3.get_translate_y  

puts "Matrix data after next change:"
puts
puts @r, @s, @t, @x, @y, @z

m.save("position.swf")
