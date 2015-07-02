#!/usr/bin/ruby
#
# startdrag.rb
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl 
# Revision 1.0 2006/05/07
#

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(7)

m = SWFMovie.new
m.set_background(0xcc, 0xcc, 0xcc)
m.set_dimension(550, 400)
m.set_rate(31)

circleshape = SWFShape.new
circleshape.set_right_fill(circleshape.add_fill(0x33, 0x33, 0x33))
circleshape.draw_circle(40)

circlesprite= SWFMovieClip.new
circlesprite.add(circleshape)
circlesprite.next_frame()
f1 = m.add(circlesprite)
f1.set_name("circle")
f1.move_to(100,100)

m.add(SWFAction.new("
 circle.onPress=function(){ this.startDrag('');};
 circle.onRelease= circle.onReleaseOutside=function(){ stopDrag();};
"))
m.save("startdrag.swf")
