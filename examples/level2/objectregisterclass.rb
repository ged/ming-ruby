#!/usr/bin/ruby
#
# objectregisterclass.rb
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.26
#
require 'ming/ming'
include Ming

set_scale(20.00000)
use_SWF_version(7)

movie = SWFMovie.new

movie.set_rate(20.000000)
movie.set_dimension(550, 400)
movie.set_number_of_frames(1)
movie.set_background(0xcc,0xcc,0xcc)

squareshape= SWFShape.new
squareshape.set_right_fill(squareshape.add_fill(255,0,0))
squareshape.move_pen_to(-50,-50)
squareshape.draw_line(100,0)
squareshape.draw_line(0,100)
squareshape.draw_line(-100,0)
squareshape.draw_line(0,-100)


holder= SWFMovieClip.new
f1 = holder.add(squareshape)
holder.next_frame

movie.add_export(holder, 'sq')

movie.write_exports

strAction = "
function movieFunct() {};
movieFunct.prototype = new MovieClip();
movieFunct.prototype.onEnterFrame = function() {this._rotation+=15;};
Object.registerClass('sq', movieFunct);
attachMovie('sq','movTest',11);
movTest._x=200;
movTest._y=200;
"

movie.add(SWFAction.new(strAction))
movie.save("objectregisterclass.swf")
