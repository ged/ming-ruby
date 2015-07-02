#!/usr/bin/ruby
# bitmapxform.rb -k
# http://ming.sourceforge.net/examples/example.php?name=bitmapxform

require 'ming/ming'
include Ming


# Ah, here's another buglet in the flash player- it doesn't seem to care about
# the second shape's bitmap's transformation in a morph.  According to spec,
# the bitmap should stretch along with the shape in this example..

set_scale(1.0)
p = SWFMorph.new

b = SWFBitmap.new("../common/alphafill.jpg")
width = b.get_width
height = b.get_height

s = p.get_shape1
f = s.add_fill(b, SWFFill::CLIPPED_BITMAP)
f.move_to(-width/2, -height/4)
f.scale_to(1.0)
s.set_left_fill(f)
s.move_pen_to(-width/2, -height/4)
s.draw_line(width, 0)
s.draw_line(0, height/2)
s.draw_line(-width, 0)
s.draw_line(0, -height/2)

s = p.get_shape2
f = s.add_fill(b, SWFFill::CLIPPED_BITMAP)

# these two have no effect!
f.move_to(-width/4, -height/2)
f.scale_to(0.5)

s.set_left_fill(f)
s.move_pen_to(-width/4, -height/2)
s.draw_line(width/2, 0)
s.draw_line(0, height)
s.draw_line(-width/2, 0)
s.draw_line(0, -height)

m = SWFMovie.new
m.set_dimension(width, height)
i = m.add(p)
i.move_to(width/2, height/2)

0.step(1000, 30) do |n|
  i.set_ratio(n/1000.0)
  m.next_frame
end

m.save("bitmapxform.swf")

