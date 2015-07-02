#!/usr/bin/ruby
#
# fractal.rb
# original script by Peter Liscovius.
# Ruby code by Pawel Karwowski pkarwow at fastmail dot fm
# Revision 1.0 2008.09.23
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6) #works only with version 6

movie = SWFMovie.new
movie.set_dimension(400,400)
movie.set_background(0xff,0xff,0xff)
movie.set_rate(31)

  f = open("./AScode/fract04_f6.as", "r")
  ary = f.readlines
       as = SWFAction.new(ary.to_s)
       movie.add(as)
  f.close

movie.save("fractal.swf")
