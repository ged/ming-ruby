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
@stream.set_dimension(200, 200)
@stream.set_frame_mode(SWFVideoStream::MODE_MANUAL)

@m.add(@stream)

0.upto(55) do |i|
    @off = @stream.seek(50, SWFVideoStream::SEEK_SET) if i == 30
    @whence = @off.to_s.to_i

    @stream.seek(@whence, SWFVideoStream::SEEK_SET) if i == 40

    @stream.next_frame
    @m.next_frame        
end

@m.save("video6.swf");
	