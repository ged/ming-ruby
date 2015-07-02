#!/usr/bin/ruby
# rbcolormatrixfilter.rb author Pawel 13.01.2008

require 'ming/ming'
include Ming

m = SWFMovie.new
m.set_background(0xcc, 0xcc, 0xcc)

bm = SWFBitmap.new("../common/MatrixFilter.jpg")
w = bm.get_width
h = bm.get_height
m.set_dimension(w, h)

shape = SWFShape.new
shape.set_right_fill(shape.add_fill(bm, SWFFill::CLIPPED_BITMAP))

shape.draw_line(w, 0)
shape.draw_line(0, h)
shape.draw_line(-w, 0)
shape.draw_line(0, -h)

col = SWFColor.new(0, 0, 0xff, 0xff)

# check link above how to set filter matrix values
ary = Array.new
ary = ary.concat([1.0, 0.0, 0.0, 0.0, 0.0])
ary = ary.concat([0.0, 1.0, 0.0, 0.0, 0.0])
ary = ary.concat([0.0, 0.0, 0.0, 0.0, 0.0])
ary = ary.concat([0.0, 0.0, 0.0, 1.0, 0.0])

# 5 x 4 matrix is obligatory !
cmf = SWFFilterMatrix.new(5, 4, ary)
f = SWFFilter::set_convolution_filter(cmf, 2.2, 21.0, col, SWFFilter::FLAG_PRESERVE_ALPHA)

mc = SWFMovieClip.new
mc.add(shape)
mc.next_frame
item = m.add(mc)
item.add_filter(f)

m.save("rbconvolutionfilter.swf")
