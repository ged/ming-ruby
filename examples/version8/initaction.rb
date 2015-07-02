#!/usr/bin/ruby
#
# initaction.rb -- Pawel Karwowski
# $Log: initaction.rb,v $
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

p = SWFMovieClip.new
i = p.add(s)
i.set_depth(1)
p.next_frame

i = m.add(p)
i.set_depth(1)
i.set_name('box')

@action = SWFAction.new("box._x = 100; box._y=100;")
@initaction = SWFInitAction.new(@action)
m.add(@initaction)

m.save("initaction.swf")
