#!/usr/bin/ruby
#
# circle.rb
# original script by Joey Lott in ActionScript Cookbook.
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.27
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6)

movie = SWFMovie.new

movie.set_dimension(500,450)
movie.set_background(0xff,0xff,0xff)
movie.set_rate(31)

  f = open("./aa/Math.as", "rb")
  ary = f.readlines
       as = SWFAction.new(ary.to_s)
       movie.add(as)
  f.close

  g = open("./aa/MovieClip.as", "rb")
  ary2 = g.readlines
       as2 = SWFAction.new(ary2.to_s)
       movie.add(as2)
  g.close

  h = open("./aa/TextField.as", "rb")
  ary3 = h.readlines
       as3 = SWFAction.new(ary3.to_s)
       movie.add(as3)
  h.close

  i = open("./aa/Table.as", "rb")
  ary4 = i.readlines
       as4 = SWFAction.new(ary4.to_s)
       movie.add(as4)
  i.close

  j = open("./aa/DrawingMethods.as", "rb")
  ary5 = j.readlines
       as5 = SWFAction.new(ary5.to_s)
       movie.add(as5)
  j.close

  k = open("./AScode/Circle.as", "rb")
  ary6 = k.readlines
       as6= SWFAction.new(ary6.to_s)
       movie.add(as6)
  k.close

holder = SWFMovieClip.new
f1 = holder.add(as6)
holder.next_frame
movie.add_export(holder, 'CircleSymbol')

  l = open("./AScode/RectangleButton.as", "rb")
  ary7 = l.readlines
       as7= SWFAction.new(ary7.to_s)
       movie.add(as7)
  l.close

holder1 = SWFMovieClip.new
f2 = holder1.add(as7)
holder1.next_frame
movie.add_export(holder1, 'RectangleButtonSymbol')

  m = open("./AScode/Circle1.as", "rb")
  ary8 = m.readlines
       as8= SWFAction.new(ary8.to_s)
       movie.add(as8)
  m.close

movie.save("circle.swf")
