#!/usr/bin/ruby
#
# drag.rb -- IKEGAMI Daisuke
#
# $Log: drag.rb,v $
# Revision 1.3  2008/01/20 09:14:53  baribal
# *** empty log message ***
#
#

require 'ming/ming'
include Ming

use_SWF_version(4)

s = SWFShape.new
s.set_right_fill(s.add_fill(0xff, 0, 0))
s.move_pen_to(-25, -25)
s.draw_line(50, 0)
s.draw_line(0, 50)
s.draw_line(-50, 0)
s.draw_line(0, -50)

b = SWFButton.new
b.add_character(s, SWFButton::HIT | SWFButton::UP | 
                               SWFButton::DOWN | SWFButton::OVER)

b.add_action(SWFAction.new("startDrag('/test',0);"), SWFButton::MOUSE_DOWN)
b.add_action(SWFAction.new("stopDrag();"),
             SWFButton::MOUSE_UP | SWFButton::MOUSE_UP_OUTSIDE)

p = SWFMovieClip.new
p.add(b)
p.next_frame

m = SWFMovie.new
m.set_dimension(320, 240)

i = m.add(p)
i.set_name('test')
i.move_to(160, 120)

m.save('drag.swf')
