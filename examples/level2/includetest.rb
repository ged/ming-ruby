#!/usr/bin/ruby
#
# includetest.rb 
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby version by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006/12/26
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6)

movie = SWFMovie.new

movie.set_dimension(550,600)
movie.set_background(0xcc,0xcc,0xcc)
movie.set_rate(31)

  f = open("../common/include_output.as", "r")
  array = f.readlines
  as = SWFAction.new(array.to_s)
  movie.add(as)
  f.close

movie.save("includetest.swf",9)
