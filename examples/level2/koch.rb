#!/usr/bin/ruby
# koch.rb -k
# http://blue.ribbon.to/~harpy/ming/example/fractal/show.php?koch.php
# http://www.kumamushi.org/~k/ming

require 'ming/ming'
include Ming
include Math

set_scale(1.0)

def draw_koch(s, len, mlev, lev, rad)
  if lev == mlev
    # buggy! accumulates tolerance
    l = len.to_f / 3 ** lev
    x = l * cos(rad)
    y = l * sin(rad)
    s.draw_line(x, y)
  else
    draw_koch(s, len, mlev, lev + 1, rad)
    draw_koch(s, len, mlev, lev + 1, rad - PI/3)
    draw_koch(s, len, mlev, lev + 1, rad + PI/3)
    draw_koch(s, len, mlev, lev + 1, rad)
  end
end

m = SWFMovie.new
m.set_rate(0.5)			# speed : default 1
m.set_dimension(600,600)

(0...4).each do |j|
  s = SWFShape.new
  s.set_line(4, 0, 0x40, 0xe0, 0xe0)
  s.move_pen_to(-200, 0)
  draw_koch(s, 400, j, 0, 0)

  i1 = m.add(s)
  i1.move(300, 300 - 400/2 * tan(PI/6))
  i2 = m.add(s)
  i2.rotate(120)
  i2.move(300 - (400/2 * sin(PI/6)), 300 + (400/2 * sin(PI/6)*tan(PI/6)))
  i3 = m.add(s)
  i3.rotate(-120)
  i3.move(300 + (400/2 * sin(PI/6)), 300 + (400/2 * sin(PI/6)*tan(PI/6)))

  m.next_frame

  m.remove(i1)
  m.remove(i2)
  m.remove(i3)
end

m.save('koch.swf')
