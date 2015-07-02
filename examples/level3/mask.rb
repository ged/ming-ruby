#!/usr/bin/ruby
#
# mask.rb
# original script by Joey Lott in ActionScript Cookbook.
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.27
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6)

movie = SWFMovie.new
movie.set_dimension(500,400)
movie.set_background(0xff,0xff,0xff)
movie.set_rate(31)

  f = open("./aa/DrawingMethods.as", "r")
  ary = f.readlines
       as = SWFAction.new(ary.to_s)
       movie.add(as)
  f.close

  g = open("./AScode/Mask.as", "r")
  ary2 = g.readlines
       as2 = SWFAction.new(ary2.to_s)
       movie.add(as2)
  g.close

movie.save("mask.swf")
