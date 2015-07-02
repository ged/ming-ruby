#!/usr/bin/ruby
# blink.rb -k
# http://blue.ribbon.to/~harpy/ming/example/color/show.php?blink.php
# http://www.kumamushi.org/~k/ming

require 'ming/ming'
include Ming

set_scale(1.0)

m = SWFMovie.new
m.set_dimension(600,600)

s = SWFShape.new
#s.set_line(4, 0x00, 0xc0, 0xff)
f = s.add_fill(0x00, 0xff, 0x80, 0x80)
s.set_right_fill(f)	# not supported -> s.set_right_fill(0x00, 0xff, 0x80)
s.move_pen_to(-200, -200)
s.draw_line(400, 0)
s.draw_line(0, 400)
s.draw_line(-400, 0)
s.draw_line(0, -400)

i = m.add(s)
i.move_to(300, 300)

1.upto(24) do |j|
  i.mult_color(1.0, 1.0, 1.0, j/24.0)
  i.rotate_to(-360.0/4/24*j)
  m.next_frame
end

1.upto(24) do |j|
  i.mult_color(1.0, 1.0, 1.0, (24-j)/24.0)
  i.rotate_to(-360.0/4/24*j)
  m.next_frame
end

m.save('blink.swf')

