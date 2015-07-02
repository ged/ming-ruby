#!/usr/bin/ruby
#
# mingplusas.rb 
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby version by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006/05/07
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(7)

m = SWFMovie.new
m.set_background(33,33,33);
m.set_rate(31); 
m.set_dimension(550,400);

csize=80;
circle = SWFShape.new
circle.set_line(3,170,170,220)
circle.draw_circle(csize)

sp = SWFMovieClip.new
f1=sp.add(circle)
f1.move_to(0,csize/2)
sp.next_frame

clips= Array.new
holder = SWFMovieClip.new

(0...12).each do |i|
clips[i]=holder.add(sp)
clips[i].move_to(275,200)
clips[i].rotate_to(30*i)
holder.next_frame
holder.next_frame
end

(0...44).each do |k|
holder.next_frame
end

(0...12).each do |i|
holder.remove(clips[i])
holder.next_frame()
holder.next_frame()
end

f1=m.add(holder)
f1.set_name("mc")

strAction="
controls = {
onMouseDown: function () {
mc._xscale=mc._yscale+=2;
},onKeyDown: function () {
mc._xscale=mc._yscale-=2;
}};
Mouse.addListener(controls);
Key.addListener(controls);
onEnterFrame=function(){
	mc._x=_xmouse-275;
	mc._y=_ymouse-200;
};
";

m.add(SWFAction.new(strAction))
m.save("mingplusas.swf")
