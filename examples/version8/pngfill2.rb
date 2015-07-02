#!/usr/bin/ruby
# jpegfill.rb -k
# http://ming.sourceforge.net/examples/example.php?name=jpegfill

require 'ming/ming'
include Ming

m = SWFMovie.new
b = SWFBitmap.new("../common/image01.png")
i = m.add(b)
m.set_dimension(b.get_width, b.get_height)

m.save("pngfill2.swf")

