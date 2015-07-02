#!/usr/bin/ruby
# javascript.rb 
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006.12.26
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(7)

movie = SWFMovie.new
movie.set_dimension(550,400)
movie.set_background(0xcc,0xcc,0xcc)
movie.set_rate(12)

squareshape = SWFShape.new 
squareshape.set_line(4,0,0,0) 
squareshape.set_right_fill(squareshape.add_fill(255,0,0))
squareshape.move_pen_to(-50,-50)
squareshape.draw_line(100,0)
squareshape.draw_line(0,100) 
squareshape.draw_line(-100,0) 
squareshape.draw_line(0,-100) 

b = SWFButton.new
b.add_character(squareshape, SWFButton::HIT | SWFButton::UP | SWFButton::DOWN | SWFButton::OVER)
b.add_action(SWFAction.new("this.geturl('javascript:alert(\"you pressed the button\")');"), SWFButton::MOUSE_DOWN)
i= movie.add(b)
i.move_to(200,200)

movie.save("javascript.swf")
