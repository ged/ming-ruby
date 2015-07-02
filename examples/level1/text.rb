#!/usr/bin/ruby
# text.rb
# example for Ming/Ruby
# http://blue.ribbon.to/~harpy/ming/example/hello/show.php?hello.php

require 'ming/ming'
include Ming

set_scale(1.0)

text = 'Hello world!'

m = SWFMovie.new
m.set_dimension(400, 400)

f = SWFFont.new("../common/Verdana.fdb")
t = SWFText.new

t.set_font(f)
t.set_color(0x00, 0x80, 0x40)
t.set_height(56)
t.move_to(- t.get_width(text)/2, t.get_ascent/2)
t.add_string(text)

i = m.add(t)
i.move_to(200, 200)
m.next_frame

m.save('text.swf')


