#!/usr/bin/ruby
#
# soundbutton2.rb -- based upon newbutton.rb by IKEGAMI Daisuke
# original is http://ming.sourceforge.net/examples/example.php?name=newbutton
# $Log: soundbutton.rb,v $
# Revision 1.2  2008/02/03 10:51:17  baribal
# *** empty log message ***
#
# Revision 1.1  2007/12/28 13:41:29  baribal
# *** empty log message ***
#
# Revision 1.0  2007/05/15 18:33:21  baribal
# NEWS: version 0.1.9 shipped.
#

require 'ming/ming'
include Ming

def rect(r, g, b)
  s = SWFShape.new
  s.set_right_fill(s.add_fill(r, g, b))
  s.draw_line(50, 0)
  s.draw_line(0, 50)
  s.draw_line(-50, 0)
  s.draw_line(0, -50)

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


@soundfile="../common/toggled.wav"
@sound1 = SWFSound.new(@soundfile, SWFSound::KHZ_5 | SWFSound::BITS_16 | SWFSound::STEREO)
@sound2 = SWFSound.new(@soundfile, SWFSound::KHZ_11 | SWFSound::BITS_16 | SWFSound::STEREO)
@sound3 = SWFSound.new(@soundfile, SWFSound::KHZ_22 | SWFSound::BITS_16 | SWFSound::STEREO)

$soundinstance = b.add_sound(@sound1, SWFButton::MOUSE_DOWN)
$soundinstance2 = b.add_sound(@sound2, SWFButton::MOUSE_OUT)
b.add_sound(@sound3, SWFButton::MOUSE_UP)

$soundinstance.set_loop_count(20)
$soundinstance.set_loop_out_point(2000)
$soundinstance.set_no_multiple()


$soundinstance2.set_loop_count(20)
$soundinstance2.set_loop_in_point(0)
$soundinstance2.set_loop_out_point(4000)
$soundinstance2.set_no_multiple()


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

m.save("soundbutton2.swf")
