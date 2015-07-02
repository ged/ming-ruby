#!/usr/bin/ruby
# cxform.rb -k
# http://www.opaque.net/ming/examples/example.php?name=cxform

require 'ming/ming'
include Ming

use_SWF_version(7)
set_scale(20.0000000)

b = SWFBitmap.new("../common/alphafill.jpg")

m = SWFMovie.new

i = m.add(b)

m.set_dimension(b.get_width(), b.get_height())
#m.set_dimension(600, 400)
#set_scale(1.0)

0.upto(19) do |n|
  i.mult_color(1.0 - n.to_f/10, 1.0, 1.0, 0.5)
  i.add_color(0xff * n.to_f/20, 0, 0)
  m.next_frame
end

20.downto(1) do |n|
  i.mult_color(1.0 - n.to_f/10, 1.0, 1.0, 0.5)
  i.add_color(0xff * n.to_f/20, 0, 0)
  m.next_frame
end

m.save('cxform.swf')
