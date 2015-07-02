#!/usr/bin/ruby
#
# button.rb -- IKEGAMI Daisuke
# original is http://ming.sourceforge.net/examples/example.php?name=newbutton
# $Log: button.rb,v $
# Revision 1.3  2008/01/20 09:14:53  baribal
# *** empty log message ***
#
#

require 'ming/ming'
include Ming

set_scale(1.0)

def makeRect(r, g, b)
  s = SWFShape.new
  s.set_right_fill(s.add_fill(r, g, b))
  s.move_pen_to(-500, -500)
  s.draw_line_to(500, -500)
  s.draw_line_to(500, 500)
  s.draw_line_to(-500, 500)
  s.draw_line_to(-500, -500)

  s
end

b = SWFButton.new
b.set_up(makeRect(0xff, 0, 0))
b.set_over(makeRect(0, 0xff, 0))
b.set_down(makeRect(0, 0, 0xff))
b.set_hit(makeRect(0, 0, 0))

m = SWFMovie.new
m.set_dimension(2000,2000)
m.set_background(0xff, 0xff, 0xff)

i = m.add(b)
i.move_to(1000,1000)

m.save("button.swf")
