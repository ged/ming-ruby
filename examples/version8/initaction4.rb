#!/usr/bin/ruby
#
# initaction.rb -- Pawel Karwowski
# $Log: initaction4.rb,v $
# Revision 1.2  2008/09/27 18:59:10  baribal
# *** empty log message ***
#
# Revision 1.1  2008/09/27 15:58:46  baribal
# *** empty log message ***
#
# Revision 1.0  2008/09/26 18:24:37  baribal
# *** empty log message ***
#
#

require 'ming/ming'
include Ming

use_SWF_version(7)

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

i = m.add(mc)
i.set_depth(1)
i.set_name('box')

@action = SWFAction.new("box._x = 100; box._y=100;")

mc.add_init_action(@action)
m.add_export(mc, "test")
m.add(mc)
@action2 = SWFAction.new("_root.attachMovie('test', 'test1', 11); test1._x=200; test1._y=200;")
@action2.set_debug
m.add(@action2)

m.save("initaction4.swf")
