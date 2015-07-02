#!/usr/bin/ruby
# rubygut.rb author Pawel

require 'ming/ming'
include Ming

m = SWFMovie.new
m.set_dimension(640, 480)


shape = SWFShape.new
shape.set_line(4, 25, 0, 0 ,128)
shape.move_pen_to(5, 5)
shape.draw_line_to(0, 10)

blur = SWFBlur.new(15,15,2)
f = SWFFilter::set_blur_filter(blur)

b = SWFButton.new
b.add_character(shape, SWFButton::UP | SWFButton::HIT| SWFButton::OVER | SWFButton::DOWN)

item = m.add(b)
item.scale_to(10)
item.add_filter(f)

m.save("rbblurfilter.swf")
