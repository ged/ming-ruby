#!/usr/bin/ruby
#
# newbutton.rb -- IKEGAMI Daisuke
# original is http://ming.sourceforge.net/examples/example.php?name=newbutton
# $Log: newbutton.rb,v $
# Revision 1.3  2008/01/20 09:14:53  baribal
# *** empty log message ***
#
#


require 'ming/ming'
include Ming

def rect(r, g, b)
  s = SWFShape.new
  s.set_right_fill(s.add_fill(r, g, b))
  s.draw_line(100, 0)
  s.draw_line(0, 100)
  s.draw_line(-100, 0)
  s.draw_line(0, -100)

  s
end

b = SWFButton.new
b.add_character(rect(0xff, 0, 0), SWFButton::UP | SWFButton::HIT)
b.add_character(rect(0, 0xff, 0), SWFButton::OVER)
b.add_character(rect(0, 0, 0xff), SWFButton::DOWN)

b.add_action(SWFAction.new("_root.label = 'MOUSE_UP';"),
	        SWFButton::MOUSE_UP)

b.add_action(SWFAction.new("_root.label = 'MOUSE_DOWN';"),
             SWFButton::MOUSE_DOWN)

b.add_action(SWFAction.new("_root.label = 'MOUSE_OVER';"),
             SWFButton::MOUSE_OVER)

b.add_action(SWFAction.new("_root.label = 'MOUSE_OUT';"),
             SWFButton::MOUSE_OUT)

b.add_action(SWFAction.new("_root.label = 'MOUSE_UP_OUTSIDE';"),
             SWFButton::MOUSE_UP_OUTSIDE)

b.add_action(SWFAction.new("_root.label = 'DRAG_OVER';"),
             SWFButton::DRAG_OVER)

b.add_action(SWFAction.new("_root.label = 'DRAG_OUT';"),
             SWFButton::DRAG_OUT)

m = SWFMovie.new
m.set_dimension(320, 240)

t = SWFTextField.new
t.set_font(SWFBrowserFont.new('_serif'))
t.add_string('NO ACTION')
t.set_height(20)
t.set_bounds(320, 20)
t.set_name('label')

i = m.add(t)
i.move_to(20, 200)

i = m.add(b)
i.move_to(20, 40)

m.save('newbutton.swf')
