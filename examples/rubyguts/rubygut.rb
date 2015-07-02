#!/usr/bin/ruby
# rubygut.rb author Pawel

require 'ming/ming'
include Ming

m = SWFMovie.new
m.set_dimension(640, 480)

s = SWFShape.new
b = SWFBitmap.new("../common/image01.png")
   s.set_right_fill(s.add_fill(b, SWFFill::CLIPPED_BITMAP))

i = m.add(b)
i.move_to(20, 40)

c = SWFColor.new(0xff,0xdd,0xcc,0xdd)

c.object_id

ObjectSpace.each_object(SWFColor) {|x| p x }

m.save("rubygut.swf")
