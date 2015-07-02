#!/usr/bin/ruby

require'ming/ming'
include Ming

set_scale(20.000000)
use_SWF_version(9)

@m= SWFMovie.new
@m.set_dimension(550, 400)
@m.set_background(0x33, 0x33, 0x33)
@m.set_rate(12.0)

@stream= SWFVideoStream.new()
@m.add(@stream)

@stream2= SWFVideoStream.new()
@m.add(@stream2)

@m.save("video2.swf")
