#!/usr/bin/ruby
# Author: Peter Liscovius
# Example file of SWFSound and SWFSoundInstance clesses.
# Ruby code by Pawel Karwowski

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(8)

$m = SWFMovie.new
$m.set_dimension(200, 100)
$m.set_background(0xff, 0xff, 0x0)
$m.set_rate(12.0)

$soundfile="../common/toggled.wav"


# some misuse of one wavfiles ;-)
$sound = SWFSound.new($soundfile, SWFSound::KHZ_22 | SWFSound::BITS_8 | SWFSound::MONO)
$sound2 = SWFSound.new($soundfile, SWFSound::KHZ_5 | SWFSound::BITS_8 | SWFSound::MONO)

# now let's do some funny noisepattern...
$soundinstance = $m.start_sound($sound)
$soundinstance.set_loop_count(20)
$soundinstance.set_loop_out_point(2000)
$soundinstance.set_no_multiple()

$m.next_frame();

0.upto(5) do 
	$m.next_frame
end

$soundinstance2=$m.start_sound($sound2)
$soundinstance2.set_loop_count(20)
$soundinstance2.set_loop_in_point(0)
$soundinstance2.set_loop_out_point(4000)
$soundinstance2.set_no_multiple()

0.upto(5) do 
	$m.next_frame
end

$m.save("sound_wav.swf")
