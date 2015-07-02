#!/usr/bin/ruby
#
# attachmovie.rb
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.05.07
#

require 'ming/ming'
include Ming

use_SWF_version(7)
set_scale(20.0000000)

m = SWFMovie.new
m.set_rate(20.000000)
m.set_dimension(550, 400)
m.set_background(0xcc,0xcc,0xcc)

def makebevel (w, h, bv, r, g, b, l, d)

myshape = SWFShape.new 
myshape.set_line(0,0,0,0)
myshape.set_right_fill(myshape.add_fill(r,g,b)) 
myshape.draw_line(w,0)  
myshape.draw_line(0,h) 
myshape.draw_line(-w,0) 
myshape.draw_line(0,-h) 

myshape.set_right_fill(myshape.add_fill(l,l,l))
myshape.draw_line(-bv,-bv) 
myshape.draw_line(w+(2*bv),0) 
myshape.draw_line(-bv,bv) 
myshape.draw_line(-w,0) 

myshape.set_right_fill(myshape.add_fill(l,l,l))
myshape.draw_line(0,h)
myshape.draw_line(-bv,bv) 
myshape.draw_line(0,-h-(2*bv)) 
myshape.draw_line(bv,bv)

myshape.move_pen_to(0, h) 

myshape.set_right_fill(myshape.add_fill(d,d,d)) 
myshape.draw_line(w,0)
myshape.draw_line(bv,bv) 
myshape.draw_line(-w-(2*bv),0) 
myshape.draw_line(bv,-bv)

myshape.move_pen_to(w,h)

myshape.set_right_fill(myshape.add_fill(d,d,d)) 
myshape.draw_line(0,-h)
myshape.draw_line(bv,-bv)
myshape.draw_line(0,h+(2*bv)) 
myshape.draw_line(-bv,-bv)
end

mybevelshape= makebevel(300,200,4,0xaa,0x66,0x66,0xee,0x11)

holder= SWFMovieClip.new
f1 = holder.add(mybevelshape)
holder.next_frame()

m.add_export(holder, 'bev')

m.write_exports()
#m.next_frame()

strAction = "
 _root.attachMovie('bev','bev1',11);
 bev1.useHandCursor=0;bev1._x=100;bev1._y=100;
 bev1.onPress=function(){ this.startDrag('');};
 bev1.onRelease= bev1.onReleaseOutside=function(){ stopDrag();};
"

m.add(SWFAction.new(strAction))
m.save("attachmovie.swf")
