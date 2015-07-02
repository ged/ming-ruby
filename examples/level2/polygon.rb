#!/usr/bin/ruby
# polygon.rb -k
# http://blue.ribbon.to/~harpy/ming/example/polygon/show.php?polygon.php
# http://www.kumamushi.org/~k/ming

require 'ming/ming'
include Ming
include Math

set_scale(1.0)

def draw_polygon(s, n, r)
  s.move_pen_to(r, 0)
  1.upto(n) do |i|
    s.draw_line_to(r * cos(i * 2 * PI / n), r * sin(i * 2 * PI / n))
  end
end

def add_frame(m, j)
  s = SWFShape.new
  s.set_line(1, 0, 0, 0)
  draw_polygon(s, j, 200)

  i = m.add(s)
  i.rotate_to(90)
  i.move_to(300, 300)

  m.next_frame
  m.remove(i)
end

m = SWFMovie.new
m.set_dimension(600,600)

3.upto(19) do |j|
  add_frame(m, j)
end

20.downto(4) do |j|
  add_frame(m, j)
end

m.save('polygon.swf')

