#!/usr/bin/ruby
# swfbitmap.rb -k
# http://ming.sourceforge.net/examples/example.php?name=png

require 'ming/ming'
include Ming

m = SWFMovie.new

s = SWFShape.new
b = SWFBitmap.new("../common/backyard.jpg")
   s.set_right_fill(s.add_fill(b, SWFFill::CLIPPED_BITMAP))

w = b.get_width
h = b.get_height
s.draw_line(w, 0)
s.draw_line(0, h)
s.draw_line(-w, 0)
s.draw_line(0, -h)

m.set_dimension(w, h)
m.add(s)

m.save("swfbitmap.swf")
