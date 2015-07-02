#!/usr/bin/ruby
#
# stream_mp3 -- Karwowski Pawel
# Example file of SWFSoundStream class
# $Log: stream_flv.rb,v $
# Revision 1.1  2008/09/25 21:01:21  baribal
# *** empty log message ***
#
# Revision 1.3  2008/09/25 21:08:30  baribal
# *** empty log message ***

require 'ming/ming'
include Ming

set_scale(20.000000)
use_SWF_version(8)

@m = SWFMovie.new
@m.set_background(0xcc, 0xcc, 0xcc)
@m.set_dimension(320, 240)
@m.set_rate(31)

0.upto(5) do |i|
@m.next_frame
end

@sstr = SWFSoundStream.new("../common/video01.flv")
@m.set_sound_stream(@sstr)

@m.set_number_of_frames(@sstr.get_duration/31)

@m.save("stream_flv.swf")
