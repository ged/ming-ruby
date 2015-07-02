#!/usr/bin/ruby
# welcome.rb -k
# Author: Przemyslaw Bieniek
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.26
#

require 'ming/ming'
include Ming

set_scale(20.000000)
use_SWF_version(7)

movie = SWFMovie.new
movie.set_dimension(560,380)
movie.set_background(0xdd,0xdd,0xcc)
movie.set_rate(60)

myFont= SWFFont.new("../common/Verdana.fdb")
myText1= SWFText.new
myText1.set_font(myFont)
myText1.set_color(20,20,20,20)
myText1.set_height(10)
myText1.move_to(-(myFont.get_width("Hello World and Moon!"))/10,0)
myText1.add_string("Hello World and Moon!")

firstText=movie.add(myText1)
firstText.move_to(260,200)
firstText.scale_to(2.3,2.3)

i = 0
while i < 60
 movie.next_frame
 firstText.rotate(-18)
 firstText.mult_color(i/3,i/3,i/3,i/3)
 firstText.scale_to(5*i/60,5*i/60)
 i = i + 1
end

j = 0
while j < 15
 movie.next_frame
 j = j + 1
end

k = 0
while k < 20
 movie.next_frame
 firstText.move(-2,0)
 firstText.rotate(1)
 k = k + 1
end

l = 0
while l < 40
 movie.next_frame
 firstText.move(2*l,0)
 l = l + 1
 if (l<10)
 firstText.rotate(-2);
 end
end

movie.next_frame

movie.save("welcome.swf")
