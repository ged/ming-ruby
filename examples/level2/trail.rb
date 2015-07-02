#!/usr/bin/ruby
# trail.rb 
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006.12.26
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6); #works only with Version(6)

movie = SWFMovie.new
movie.set_dimension(550,400)
movie.set_background(0xcc, 0xcc, 0xcc )
movie.set_rate(31)

c = SWFShape.new
c.set_right_fill(c.add_fill(0,0,125))
c.draw_circle(6)

h= SWFMovieClip.new
f = h.add(c)
h.next_frame
movie.add_export(h, 'mc')
movie.write_exports

strAction = "
dot = [];
num=17;
for(i=0;i<num;i++){
	dot[i]=_root.attachMovie('mc','mc'+i,i+10);
	dot[i]._x=12*i;
    dot[i]._y=200;
}
dot[0].startDrag(true);

a=0.2;
b=0.6;

_root.onEnterFrame = function(){
i=0;
while(++i<num){
dot[i].x= (dot[i].x + (dot[i-1]._x + 12 - dot[i]._x)*a)*b;
dot[i].y= (dot[i].y + (dot[i-1]._y - dot[i]._y)*a)*b;
}
i=0;
while(++i<num){
dot[i]._x+=dot[i].x;
dot[i]._y+=dot[i].y;
}

};
";

movie.add(SWFAction.new(strAction))
movie.save("trail.swf")

