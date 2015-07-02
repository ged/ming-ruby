#!/usr/bin/ruby
# simple swfsound stop example
# code by gazb : gazb dot ming at NOSPAM gmail dot com
# August 2004
#  http://www16.brinkster.com/gazb/ming/
# Ruby code by Pawel Karwowski pkarwow at fastmail dot fm

require 'ming/ming'
include Ming

@movie = SWFMovie.new 
@movie.set_dimension(550,400)

@movie.set_background(0xff, 0x33, 0x33)

# create SWFSound object : flags set to audiofile lib "sfinfo" output
@soundobject = SWFSound.new("../common/wipe.au", SWFSound::KHZ_22 | SWFSound::BITS_16 | SWFSound::MONO)
# adding sound object to movie returns SWFSoundInstance
@soundinstance=@movie.start_sound(@soundobject)
# which can customise the playback of the instance
# loop sound 999 times (we will stop it before it gets to 999)
@soundinstance.set_loop_count(999)
# set small loop in point just to prevent "clicks"
@soundinstance.set_loop_in_point(1 *100)
# add some frames where sound will loop
0.upto(20) do
@movie.next_frame
end
# stop that sound
@movie.stop_sound(@soundobject)
# add some frames where sound will not loop
0.upto(50) do
@movie.next_frame
end

@movie.save("swfsoundstop.swf",9)

