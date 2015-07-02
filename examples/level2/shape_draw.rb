#!/usr/bin/ruby
#
# shape_draw.rb
# Author: Peter Liscovius
# 2002
# ming paint example
# demonstrates line, curve and cubic-curve painting
#
# Ruby code by Pawel Karwowski pkarwow at fastmail dot fm
# Revision 1.0 2008.27.09
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(9)

m = SWFMovie.new

m.set_dimension(300,300)
m.set_background(0xff,0xff,0xff)
m.set_rate(31)

0.upto(30) do |i|
    @s = SWFShape.new
    @s.set_line(1,i*10,150-i*10,0)
    @s.move_pen_to(150,0)
    @s.draw_line_to(50+i*5,40)
    
    @tox,@toy = 50, 50
    @dx1,@dy1 = -50+i*10,100
    @dx2,@dy2 = 200-i*10,-100
    @s.move_pen_to(@tox,@toy)
    
    @s.draw_curve(@dx1,@dy1,@dx2,@dy2)
    @s_n=m.add(@s)
    @s_n.move(1,10)

end

0.upto(30) do |i|
    
    @tox,@toy = 0, 0
    @bdx,@bdy = 0-i*10,-100+i*10
    @cdx,@cdy = 50+i*20, 150-i*10
    @ddx,@ddy = 0-i*10,-50

    @s = SWFShape.new
    @s.set_line(1,i*10,150-i*10,0)
    @s.move_pen_to(@tox,@toy)
    @s.draw_cubic(@bdx,@bdy,@cdx,@cdy,@ddx,@ddy)
    @s_n=m.add(@s)
    @s_n.move(120,160)
    m.next_frame

end


m.next_frame

m.save("shape_draw.swf",9)

