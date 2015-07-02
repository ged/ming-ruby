#!/usr/bin/ruby

require 'ming/ming'
include Ming

class ITEM
	attr_accessor :i, :x, :y, :rot, :s
end

string = "ming!"

f = SWFFont.new("../common/Impact.fdb")

m = SWFMovie.new
m.set_rate(24.0)
m.set_dimension(2400, 1600)
m.set_background(0xff, 0xff, 0xff)

# functions with huge numbers of arbitrary
# arguments are always a good idea!  Really!

def text(f, m, r, g, b, a, rot, x, y, scale, string)

  t = SWFText.new
  t.set_font(f)
  t.set_color(r, g, b, a)
  t.set_height(960)
  t.move_to(-(t.get_width(string))/2.0, 220)   # f.getAscent()/2)
  t.add_string(string)

  i = ITEM.new
  i.i = m.add(t)
  i.x = x
  i.y = y
  i.rot = rot
  i.s = scale
  i.i.rotate_to(rot)
  i.i.scale(scale, scale)

  return i
end

def step(i)

  i.rot = 19*i.rot/20.0
  i.x = (19*i.x + 1200)/20.0
  i.y = (19*i.y + 800)/20.0
  i.s = (19*i.s + 1.0)/20.0

  i.i.rotate_to(i.rot)
  i.i.scale_to(i.s, i.s)
  i.i.move_to(i.x, i.y)
end


# see?  it sure paid off in legibility:

i1 = text(f, m, 0xff, 0x33, 0x33, 0xff, 900, 1200, 800, 0.03, string)
i2 = text(f, m, 0x00, 0x33, 0xff, 0x7f, -560, 1200, 800, 0.04, string)
i3 = text(f, m, 0xff, 0xff, 0xff, 0x9f, 180, 1200, 800, 0.001, string)

for i in 1...101
  step(i1)
  step(i2)
  step(i3)

  m.next_frame
end

m.save("animation.swf")
