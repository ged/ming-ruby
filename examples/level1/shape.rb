#!/usr/bin/env ruby
#
# shape.rb -- Daisuke IKEGAMI
# original is http://ming.sourceforge.net/examples/example.php?name=shape
# $Log: shape.rb,v $
# Revision 1.3  2008/01/20 09:14:53  baribal
# *** empty log message ***
#
#

require 'ming/ming'
include Ming

s = SWFShape.new
s.set_line(4, 0x7f, 0, 0)
s.set_right_fill(s.add_fill(0xff, 0, 0))
s.move_pen_to(10, 10)
s.draw_line_to(310, 10)
s.draw_line_to(310, 230)
s.draw_curve_to(10, 230, 10, 10)

m = SWFMovie.new;
m.set_dimension(320, 240)
m.set_rate(12.0)
m.add(s)
m.save('shape.swf')
