#!/usr/bin/ruby
#
# initaction.rb -- Pawel Karwowski
# $Log: initaction2.rb,v $
# Revision 1.3  2008/09/27 15:58:46  baribal
# *** empty log message ***
#
# Revision 1.0  2008/09/26 18:24:37  baribal
# *** empty log message ***
#
#

require 'ming/ming'
include Ming

m = SWFMovie.new
m.set_background(0xff, 0xff, 0xff)
m.set_dimension(320, 240)

s = SWFShape.new
f = s.add_fill(0xff, 0, 0)
s.set_right_fill(f)
s.move_pen_to(-25, -25)
s.draw_line_to(25, -25)
s.draw_line_to(25, 25)
s.draw_line_to(-25, 25)
s.draw_line_to(-25, -25)

mc = SWFMovieClip.new
i = mc.add(s)
i.set_depth(1)
mc.next_frame

@action = SWFAction.new("box._x = 100; box._y=100;")
mc.add_init_action(@action)
m.add_export(mc, "test")

i = m.add(mc)
i.set_depth(1)
i.set_name('box')

m.save("initaction2.swf")
