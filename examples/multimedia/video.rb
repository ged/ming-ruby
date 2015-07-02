#!/usr/bin/ruby

require'ming/ming'
include Ming

set_scale(20.000000)
use_SWF_version(9)


@m= SWFMovie.new
@m.set_dimension(550, 400)
@m.set_background(0x33, 0x33, 0x33)
@m.set_rate(12.0)

@file = '../common/video01.flv'

@stream= SWFVideoStream.new(@file)
@i = @m.add(@stream)
@i.move_to(100, 100)

#200.times do
(@stream.get_frames-1).times do
  @m.next_frame
end


@m.save("video.swf");

