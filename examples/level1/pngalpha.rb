#!/usr/bin/ruby
# pngalpha.rb -k
# http://ming.sourceforge.net/examples/example.php?name=png

require 'ming/ming'
include Ming

set_scale(1.0)
use_SWF_version(4)

m = SWFMovie.new

s = SWFShape.new
  f = s.add_fill(SWFBitmap.new("../common/alpha.dbl"), SWFFill::CLIPPED_BITMAP)
  f.move_to(-16, -16)
  s.set_right_fill(f)

  s.move_pen_to(-16, -16)
  s.draw_line(32, 0)
  s.draw_line(0, 32)
  s.draw_line(-32, 0)
  s.draw_line(0, -32)

  p = SWFMovieClip.new
  i = p.add(s)
  p.next_frame

  0.upto(90) do |n|
    i.rotate(4)
    p.next_frame
  end

   m.set_dimension(64, 48)

   i = m.add(p)
   i.move_to(24, 24)

   i = m.add(p)
   i.move_to(40, 24)

m.save("pngalpha.swf")
