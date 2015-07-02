#!/usr/bin/ruby
#
# keypress.rb -- IKEGAMI Daisuke
#


require 'ming/ming'
include Ming

use_SWF_version(4)
p = SWFMovieClip.new
p.add(SWFAction.new("stop();"))

chars = 'abcdefghijklmnopqrstuvwxyz' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        '1234567890!@#$%^&*()_+-=/[]{}|;:,.<>?`~'

f = SWFBrowserFont.new('_serif')

i = nil
chars.length.times do |n|
  c = chars[n].chr
  p.remove(i) unless i.nil?
  t = SWFTextField.new
  t.set_font(f)
  t.set_height(240)
  t.set_bounds(600, 240)
  t.set_alignment(SWFTextField::ALIGN_CENTER)
  t.add_string(c)
  i = p.add(t)
  p.label_frame(c)
  p.next_frame
end

s = SWFShape.new
s.set_right_fill(s.add_fill(0, 0, 0))
s.draw_line(600, 0)
s.draw_line(0, 400)
s.draw_line(-600, 0)
s.draw_line(0, -400)

b = SWFButton.new
b.add_character(s, SWFButton::HIT)

chars.length.times do |n|
  c = chars[n].chr
  b.add_action(SWFAction.new("setTarget('/char'); gotoFrame('#{c}');"), SWFButton::key_press(c))
end

m = SWFMovie.new
m.set_dimension(600, 400)
i = m.add(p)
i.set_name('char')
i.move_to(0, 80)

m.add(b)

m.save('keypress.swf')
