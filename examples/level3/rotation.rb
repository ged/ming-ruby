#!/usr/bin/ruby
#
# rotation.rb
# original script by Sham Bhangal in Flash hacks book.
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.27
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(7)

movie = SWFMovie.new

movie.set_dimension(500,450)
movie.set_background(0xff,0xff,0xff)
movie.set_rate(31)

  f = open("./AScode/Rotation.as", "r")
  ary = f.readlines
       as = SWFAction.new(ary.to_s)
       movie.add(as)
  f.close

movie.save("rotation.swf",9)
