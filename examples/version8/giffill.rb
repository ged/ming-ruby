#!/usr/bin/ruby
# jpegfill.rb -k
# http://ming.sourceforge.net/examples/example.php?name=jpegfill

require 'ming/ming'
include Ming

m = SWFMovie.new
m.set_dimension(319, 300)
i = m.add(SWFBitmap.new("../common/red-ball.gif"))
i.move_to(100,100)

m.save("giffill.swf")

