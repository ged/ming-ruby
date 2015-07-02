#! /usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(8)
set_scale(2.0)

p = SWFMorph.new()

g1 = SWFGradient.new()
g1.add_entry(0.0, 0, 0, 0)
g1.add_entry(0.16, 0xff, 0xff, 0xff)
g1.add_entry(0.32, 0, 0, 0)
g1.add_entry(0.48, 0xff, 0xff, 0xff)
g1.add_entry(0.64, 0, 0, 0)
g1.add_entry(0.80, 0xff, 0xff, 0xff)
g1.add_entry(1.00, 0, 0, 0)

s1 = p.get_shape1()
f1 = s1.add_fill(g1, SWFFill::RADIAL_GRADIENT)
f1.scale_to(0.005)
s1.set_left_fill(f1)
s1.move_pen_to(-160, -120)
s1.draw_line(320, 0)
s1.draw_line(0, 240)
s1.draw_line(-320, 0)
s1.draw_line(0, -240)

g2 = SWFGradient.new()
g2.add_entry(0.0, 0, 0, 0)
g2.add_entry(0.16, 0xff, 0, 0)
g2.add_entry(0.32, 0, 0, 0)
g2.add_entry(0.48, 0, 0xff, 0)
g2.add_entry(0.64, 0, 0, 0)
g2.add_entry(0.80, 0, 0, 0xff)
g2.add_entry(1.00, 0, 0, 0)

s2 = p.get_shape2()
f2 = s2.add_fill(g2, SWFFill::RADIAL_GRADIENT)
f2.scale_to(0.008)
f2.skew_x_to(-0.5)
s2.set_left_fill(f2)
s2.move_pen_to(-160, -120)
s2.draw_line(320, 0)
s2.draw_line(0, 240)
s2.draw_line(-320, 0)
s2.draw_line(0, -240)

m = SWFMovie.new
m.set_dimension(320, 240)
i = m.add(p)
i.move_to(160, 120)

0.upto(100) do |n|
i.set_ratio(n.to_f/100)
m.next_frame()
end

print "Content-type: application/x-shockwave-flash\n\n";

m.output
