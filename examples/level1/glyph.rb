#!/usr/bin/ruby
# glyph.rb
# Example of Ming for Ruby
# http://opaque.net/ming/examples/example.php?name=glyph

require 'ming/ming'
include Ming

set_scale(20.0)

s = SWFShape.new
fill = []

[
  [0xff, 0, 0],
  [0xff, 0x7f, 0],
  [0xff, 0xff, 0],
  [0, 0xff, 0],
  [0, 0, 0xff],
].each do |r, g, b|
  fill.push(s.add_fill(r, g, b))
end

f = SWFFont.new("../common/Verdana.fdb")

s.set_right_fill(fill[0])
s.set_line(2, 0x7f, 0, 0)
s.draw_glyph(f, '!')
s.move_pen(f.get_width('!'), 0)

s.set_right_fill(fill[1])
s.set_line(2, 0x7f, 0x3f, 0)
s.draw_glyph(f, '#')
s.move_pen(f.get_width('#'), 0)

s.set_right_fill(fill[2])
s.set_line(2, 0x7f, 0x7f, 0)
s.draw_glyph(f, '%')
s.move_pen(f.get_width('%'), 0)

s.set_right_fill(fill[3])
s.set_line(2, 0, 0x7f, 0)
s.draw_glyph(f, '*')
s.move_pen(f.get_width('*'), 0)

s.set_right_fill(fill[4])
s.set_line(2, 0, 0, 0x7f)
s.draw_glyph(f, '@')
s.move_pen(f.get_width('@'), 0)

m = SWFMovie.new
m.set_dimension(320, 240)

i = m.add(s)
i.scale_to(2.0, 2.0)
i.move_to(160 - f.get_width('!#%*@'), 120 + f.get_ascent)

m.save('glyph.swf')
