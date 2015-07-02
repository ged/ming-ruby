#!/usr/bin/ruby
#
# dotted.rb - Anonymous
# original is http://ming.sourceforge.net anonymous post on ming-users list
# $Log: dotted.rb,v $
# Revision 1.1  2007/12/28 13:41:28  baribal
# *** empty log message ***
#
# Revision 1.0  2006/12/27 17:51:10 Ruby code by Pawel Karwowski
# initial commit
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6)

movie = SWFMovie.new

movie.set_dimension(500,450)
movie.set_background(0xff,0xff,0xff)
movie.set_rate(31)

  f = open("./AScode/Dotted.as", "r")
  ary = f.readlines
       as = SWFAction.new(ary.to_s)
       movie.add(as)
  f.close

movie.save("dotted.swf",9)
