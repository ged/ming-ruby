#!/usr/bin/ruby
# jpegfill.rb -k
# http://ming.sourceforge.net/examples/example.php?name=jpegfill

require 'ming/ming'
include Ming

m = SWFMovie.new
m.set_dimension(319, 300)
i = m.add(SWFBitmap.new("../common/image01.png"))
i.scale_to(5)

m.save("pngfill.swf")

