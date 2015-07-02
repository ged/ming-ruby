#!/usr/bin/ruby
# fill2.rb -k
# http://ming.sourceforge.net/examples/example.php?name=alphafill

require 'ming/ming'
include Ming

use_SWF_version(9)

@c = SWFShape.new
@d = SWFShape.new
@e = SWFShape.new

@b = SWFBitmap.new("../common/image01.png")
@i = SWFFillStyle.new(@b, SWFFill::TILED_BITMAP)
@f = SWFFillStyle.new(0x22, 0, 0xff, 0x99)
@g = SWFGradient.new
@g.add_entry(0.0, 0xff, 0xff, 0, 0x88)
@g.add_entry(1.0, 0xff, 0, 0, 0x88)
@h = SWFFillStyle.new(@g, SWFFill::RADIAL_GRADIENT)

@c.set_right_fill_style(@h)
@d.set_right_fill_style(@f)
@e.set_right_fill_style(@i)


@c.move_pen_to(10,10)

@c.set_line(1,0,0,0)
@c.draw_line(540, 0)
@c.draw_line(0, 140)
@c.draw_line(-540, 0)
@c.draw_line(0, -140)

@d.move_pen_to(100,250)
@d.draw_circle(70)

@e.move_pen_to(400,250)
@e.draw_circle(70)

@m = SWFMovie.new
@m.set_dimension(600,400)
@m.set_background(0xcc, 0xcc, 0xcc)

@m.add(@c)
@m.add(@d)
@m.add(@e)

@m.save("fillstyle.swf")