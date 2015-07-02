#!/usr/bin/ruby
# hello_rotate.rb -k
# http://blue.ribbon.to/~harpy/ming/example/hello/show.php?hello_rotate.php
# http://www.kumamushi.org/~k/ming

require 'ming/ming'
include Ming

text = "Hello World"

m = SWFMovie.new
m.set_dimension(400,400)

f = SWFFont.new("../common/Verdana.fdb")
t = SWFText.new

t.set_font(f)
t.set_color(0x00, 0x80, 0x40)
t.set_height(56)
t.move_to(-t.get_width(text)/2, t.get_ascent/2)
t.add_string(text)

i = m.add(t)
i.move_to(400/2, 400/2)
0.step(360, 15) do |j|
  i.rotate_to(-j)
  m.next_frame
end

m.save('hello_rotate.swf')
