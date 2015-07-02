#!/usr/bin/ruby
#
# grid.rb
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006.05.09
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(7)

m = SWFMovie.new
m.set_dimension(600,400)
m.set_background(0xcc, 0xcc, 0xcc )
m.set_rate(31)

gridLine=SWFShape.new
gridLine.set_line(0,100,100,100)
gridLine.draw_line(16*16,0)  
gridSprite= SWFMovieClip.new

0.upto(16) do |i|
f2 = gridSprite.add(gridLine)
f2.move_to(0,i*16)
end

0.upto(16) do |i|
f2 = gridSprite.add(gridLine)
f2.rotate(270)
f2.move_to(i*16,0)
end

gridSprite.next_frame()
m.add_export(gridSprite, 'grid')
#m.next_frame()
m.write_exports()

strAction = "
_root.attachMovie('grid','grid',1);
grid._x=grid._y=50;
"
m.add(SWFAction.new(strAction))
m.save("grid.swf")
