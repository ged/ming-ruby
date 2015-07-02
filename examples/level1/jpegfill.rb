#!/usr/bin/ruby
# jpegfill.rb -k
# http://ming.sourceforge.net/examples/example.php?name=jpegfill

require 'ming/ming'
include Ming

m = SWFMovie.new
m.set_dimension(719, 900)
i = m.add(SWFBitmap.new("../common/picture.jpg"))

m.save("jpegfill.swf")

