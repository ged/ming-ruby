#!/usr/bin/ruby
# gyro.rb -k
# http://blue.ribbon.to/~harpy/ming/example/circle/show.php?test1.php
# http://www.kumamushi.org/~k/ming

require 'ming/ming'
include Ming
include Math

set_scale(1.0)

def draw_gyro(s, r, x, y)
  a = r * tan(PI/8)
  b = r * sin(PI/4)	# == sqrt(2)/2

  s.move_pen_to(x + r, y)

  s.draw_curve_to(x + r, y - a, x + b, y - b)
  s.draw_curve_to(x + a, y - r, x,     y - r)
  s.draw_curve_to(x - a, y - r, x - b, y - b)
  s.draw_curve_to(x - r, y - a, x - r, y    )
  s.draw_curve_to(x - r, y + a, x - b, y + b)
  s.draw_curve_to(x - a, y + r, x,     y + r)
  s.draw_curve_to(x + a, y + r, x + b, y + b)
  s.draw_curve_to(x + r, y + a, x + r, y    )
end

m = SWFMovie.new
m.set_dimension(600,600)
i = Array.new

(0...32).each do |j|
  s = SWFShape.new
  s.set_line(5, 0, 0x80, 0x40, 0x80)
  r = 20 * (j + 1)
  draw_gyro(s, r, 0, 0)
  i[j] = m.add(s)
  i[j].move_to(300, 300)

  j.downto(0) do |k|
    i[k].scale(0.9, 1.1)
    i[k].rotate(22.5)
  end

  m.next_frame
end

m.save('gyro.swf')
