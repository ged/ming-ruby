#!/usr/bin/ruby
# png.rb -k
# http://ming.sourceforge.net/examples/example.php?name=png

require 'ming/ming'
include Ming

m = SWFMovie.new

b = SWFBitmap.new("../common/png.dbl")
m.add(b)
m.set_dimension(b.get_width, b.get_height)
m.save("png.swf")

