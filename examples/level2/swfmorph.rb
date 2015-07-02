#!/usr/bin/ruby
# swfmorph.rb -k 
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby version by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006/12/26
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6)

@movie = SWFMovie.new
@movie.set_dimension(550,400)
@movie.set_background(0xcc,0xcc,0xcc)
@movie.set_rate(31)

@movie.add(SWFAction.new("
onMouseDown=function(){
play();
};
"))

@mymorph = SWFMorph.new

shapeToMorphFrom = @mymorph.get_shape1
shapeToMorphFrom.set_line(4,0,0,0)
shapeToMorphFrom.set_left_fill(shapeToMorphFrom.add_fill(0,0,0x66))
shapeToMorphFrom.move_pen_to(-50,-50)
shapeToMorphFrom.draw_line(50,-20)  
shapeToMorphFrom.draw_line(50,20)
shapeToMorphFrom.draw_line(20,50)  
shapeToMorphFrom.draw_line(-20,50)
shapeToMorphFrom.draw_line(-50,20)  
shapeToMorphFrom.draw_line(-50,-20) 
shapeToMorphFrom.draw_line(-20,-50)  
shapeToMorphFrom.draw_line(20,-50)

shapeToMorphTo = @mymorph.get_shape2
shapeToMorphTo.set_line(4,0,0,0)
shapeToMorphTo.set_left_fill(shapeToMorphTo.add_fill(0x66,0,0))
shapeToMorphTo.draw_circle(100);


@morph = @movie.add(@mymorph)
@morph.move_to(275,200)

i = 0
while i < 5
  @morph.set_ratio(i/5)
  @movie.next_frame
  i = i + 0.1
end

@movie.add(SWFAction.new("stop();"))
@movie.next_frame

@movie.save("swfmorph.swf")
