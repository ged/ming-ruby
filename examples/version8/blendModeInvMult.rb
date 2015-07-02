#!/usr/bin/ruby
# blendModeInvMult.rb by Pawel  13.01.2008

require 'ming/ming'
include Ming

set_scale(1.0)
use_SWF_version(9)

m = SWFMovie.new

s = SWFShape.new
  f = s.add_fill(SWFBitmap.new("../common/alpha.dbl"), SWFFill::TILED_BITMAP)
  f.move_to(-16, -16)
  s.set_right_fill(f)

  s.move_pen_to(-16, -16)
  s.draw_line(32, 0)
  s.draw_line(0, 32)
  s.draw_line(-32, 0)
  s.draw_line(0, -32)

# Check different blend mode flags...

  p = SWFMovieClip.new
  i = p.add(s)
  i.set_blend_mode(SWFBlendMode::INV)
  p.next_frame

  0.upto(90) do |n|
    i.rotate(4)
    p.next_frame
  end

   m.set_dimension(64, 48)

   i = m.add(p)
   i.set_blend_mode(SWFBlendMode::MULT)
   i.move_to(24, 24)

   i = m.add(p)
   i.move_to(40, 24)

m.save("blendModeInvMult.swf")
