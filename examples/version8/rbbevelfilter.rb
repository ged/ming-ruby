#!/usr/bin/ruby
# rubygut.rb author Pawel

require 'ming/ming'
include Ming

m = SWFMovie.new
m.set_dimension(640, 480)
m.set_background(0,0,0)

shape = SWFShape.new
shape.set_line(4, 25, 0, 0 ,128)
shape.move_pen_to(5, 5)
shape.draw_line_to(0, 10)

blur = SWFBlur.new(15,15,2)
f = SWFFilter::set_blur_filter(blur)

sh = SWFShadow.new(5,5,2)

col = SWFColor.new(0xcc, 0xcc, 0xcc, 0xff)
col1 = SWFColor.new(0, 0xff, 0, 0x88)

filter = SWFFilter::set_bevel_filter(col, col1, blur, sh, SWFFilter::FLAG_CLAMP)

b = SWFButton.new
b.add_character(shape, SWFButton::UP | SWFButton::HIT| SWFButton::OVER | SWFButton::DOWN)

item = m.add(b)
item.scale_to(10)
item.add_filter(filter)

m.save("rbbevelfilter.swf")
