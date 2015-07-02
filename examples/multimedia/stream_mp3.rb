#!/usr/bin/ruby
#
# stream_mp3 -- Karwowski Pawel
# Example file of SWFSoundStream class
# $Log: stream_mp3.rb,v $
# Revision 1.5  2008/09/25 21:01:22  baribal
# *** empty log message ***
#
# Revision 1.3  2008/07/05 21:08:30  baribal
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

@sstr = SWFSoundStream.new("../common/audio01.mp3")
@m.set_sound_stream(@sstr)

@frames = @sstr.get_frames
puts 'Number of frames read:'
puts @frames
puts
@intiger = @sstr.get_duration
puts 'Duration in miliseconds:'
puts @intiger
puts
@rate = @m.get_rate
puts 'Rate of the movie:'
puts @rate
# how to calculate parameter for set_number_of_frames method
# taking into account get_duration (in ms), number of frames read and rate of the movie?
@m.set_number_of_frames(@frames)

@m.save("stream_mp3.swf")
