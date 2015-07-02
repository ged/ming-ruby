#!/usr/bin/ruby
# buttonrecord.rb by Pawel  13.01.2008

require 'ming/ming'
include Ming

m = SWFMovie.new(9)
m.set_dimension(640, 480)
m.set_background(0xff, 0xff, 0xff)

shape = SWFShape.new
bm = SWFBitmap.new("../common/MatrixFilter.jpg")
fs = SWFFillStyle.new(bm, SWFFill::TILED_BITMAP)
	
shape.set_right_fill_style(fs)
@w = bm.get_width
@h = bm.get_height

shape.draw_line(@w, 0)
shape.draw_line(0, @h)
shape.draw_line(-@w, 0)
shape.draw_line(0, -@h)		

col = SWFColor.new(0xff, 0, 0, 0xff)

ary = Array.new
ary = ary.concat([0.0,0.0,0.0,0.0,0.0])
ary = ary.concat([0.0,1.0,0.0,0.0,0.0])
ary = ary.concat([0.0,0.0,0.0,0.0,0.0])
ary = ary.concat([0.0,0.0,0.0,1.0,0.0])
	
cmf = SWFFilterMatrix.new(5,4, ary)
f = SWFFilter::set_color_matrix_filter(cmf)

b = SWFButton.new
br = b.add_character(shape, SWFButton::UP | SWFButton::HIT | SWFButton::OVER | SWFButton::DOWN)
br.add_filter(f)
br2 = b.add_character(shape, SWFButton::OVER | SWFButton::DOWN)
br2.move_to(150, 0)
br2.add_filter(f)
br2.set_blend_mode(SWFBlendMode::SUB)
br3 = b.add_character(shape, SWFButton::DOWN)
br3.move_to(300, 0)
br3.add_filter(f)
br3.set_blend_mode(SWFBlendMode::OVER_LAY)

item = m.add(b)

m.save("buttonrecord.swf",9)
