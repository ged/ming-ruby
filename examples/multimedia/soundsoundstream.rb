#!/usr/bin/ruby
# Author: Pawel Karwowski
# Example file of getting SWFSound object from SWFSoundStream object.

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(9)

@m = SWFMovie.new
@m.set_dimension(200, 100)
@m.set_background(0xff, 0xff, 0x0)
@m.set_rate(12.0)

@file = "../common/video01.flv"

@stream= SWFSoundStream.new(@file)

@sound = SWFSound.new(@stream)

@m.start_sound(@sound)

@m.next_frame();

0.upto(200) do 
  @m.next_frame
end

@m.save("soundsoundstream.swf")
