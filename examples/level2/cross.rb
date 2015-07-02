#!/usr/bin/ruby
# cross.rb -k
# http://blue.ribbon.to/~harpy/ming/example/polygon/show.php?cross.php
# http://www.kumamushi.org/~k/ming

require 'ming/ming'
include Ming
include Math

set_scale(1.0)

def draw_cross(s, n, r)
  if n % 2
    s.move_pen_to(r, 0)
    1.upto(n) do |i|
      s.draw_line_to(r * cos(2 * i * 2 * PI / n), r * sin(2 * i * 2 * PI / n))
    end
  else
    s.move_pen_to(r, 0)
    1.upto(n / 2) do |i|
      s.draw_line_to(r * cos(2 * i * 2 * PI / n), r * sin(2 * i * 2 * PI / n))
    end
    s.move_pen_to(r * cos(2 * PI / n), r * sin(2 * PI / n))
    1.upto(n / 2) do |i|
      s.draw_line_to(r * cos((2 * i + 1) * 2 * PI / n), r * sin((2 * i + 1) * 2 * PI / n))
    end
  end
end

def add_frame(m, j)
  s = SWFShape.new
  s.set_line(1, 0, 0, 0)
  draw_cross(s, j, 200)

  i = m.add(s)
  i.rotate_to(90)
  i.move_to(300, 300)

  m.next_frame
  m.remove(i)
end

m = SWFMovie.new
m.set_dimension(600,600)

5.upto(24) do |j|
  add_frame(m, j)
end

25.downto(6) do |j|
  add_frame(m, j)
end

m.save('cross.swf')

