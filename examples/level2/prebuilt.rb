#!/usr/bin/ruby
#
# prebuilt.rb KARWOWSKI Pawel
# original is http://www16.brinkster.com
# $Log: prebuilt.rb,v $
# Revision 1.1  2007/12/28 13:41:25  baribal
# *** empty log message ***
#
# Revision 1.1  2006/12/17 18:50:00  mcdonaec
# New examples added.
#
# Revision 1.0  2006/06/09 12:20:00 pawel
# initial commit
#

require 'ming/ming'
include Ming

set_scale(20.0000000);

movie = SWFMovie.new
movie.set_dimension(550, 400)

obj = SWFPrebuiltClip.new("fill.swf");
obj1 = SWFPrebuiltClip.new("oval.swf");

i = movie.add(obj)
i1 = movie.add(obj1)
i1.move_to(210,100)
i1.scale_to(0.5)
movie.next_frame

movie.save("prebuilt.swf")

