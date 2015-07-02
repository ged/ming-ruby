#!/usr/bin/ruby
# cxform3.rb
# http://www.opaque.net/ming/examples/example.php?name=cxform

require 'ming/ming'
include Ming

use_SWF_version(9)

m = SWFMovie.new
m.set_dimension(600, 400)

s = SWFShape.new
f = s.add_fill(255,255,0)
s.set_right_fill(f)
s.move_pen_to(-200, -200)
s.draw_line(400, 0)
s.draw_line(0, 400)
s.draw_line(-400, 0)
s.draw_line(0, -400)

i = m.add(s)
i.move_to(100, 100)
0.upto(19) do |n|
  m.next_frame
end
m.label_frame("One")
m.next_frame

cx = SWFCXform.new(0x00, 0x00, 0xff, 0xff, 0, 0, 0, 0)
i.set_cxform(cx)

i.move_to(100, 100)
0.upto(19) do |n|
  m.next_frame
end
m.next_frame

19.downto(0) do |n|
  i.mult_color(1.0, 1.0 - n.to_f/30, 1.0, 1.0)
  i.add_color(0xff * n, 0, 0, 0)
  m.next_frame
end

m.named_anchor("One")
m.save("cxform.swf")
