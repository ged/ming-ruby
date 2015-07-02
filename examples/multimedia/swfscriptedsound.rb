#!/usr/bin/ruby
# move your mouse around to control volume/pan
# scripted movieclip event sound example 
# code by gazb : gazb dot ming at NOSPAM gmail dot com
# August 2004
# http://www16.brinkster.com/gazb/ming/
# Ruby code by Pawel Karwowski pkarwow at fastmail dot fm

require 'ming/ming'
include Ming

use_SWF_version(8)

@movie = SWFMovie.new
@movie.set_dimension(550,400)
@movie.set_background(0x33, 0x33, 0xff)

#  create SWFSound object : flags set to audiofile lib "sfinfo" output
@soundobject = SWFSound.new("../common/toggled.wav", SWFSound::KHZ_22 | SWFSound::BITS_16 | SWFSound::MONO)

# create circle shape
@circleshape = SWFShape.new 
@circleshape.set_right_fill(@circleshape.add_fill(255,255,0))
@circleshape.draw_circle(20);

# create SWFmovieclip
@sp = SWFMovieClip.new
# add circle shape
@f1 = @sp.add(@circleshape)
# add sound object
@soundinstance=@sp.start_sound(@soundobject)
# customise the playback of the instance
# set small loop in point just to prevent "clicks"
@soundinstance.set_loop_in_point(5 *100)
# loop sound 999 times
@soundinstance.set_loop_count(999)
# after adding content to a *movieclip* this *is* always required 
@sp.next_frame
# add movieclip to movie
@f1 = @movie.add(@sp)
# name movieclip for actionscript reference
@f1.set_name("snd")
# move it to center of screen
@f1.move_to(275,200)

# add actionscript to frame

@f1 = @movie.add(SWFAction.new("
this.snd.asSound = new Sound(this.snd);
this.snd.onEnterFrame=function(){
var xpos=(this._xmouse/275)*100;
var ypos=Math.abs((this._ymouse/200)*100);
this.asSound.setPan(xpos);
this.asSound.setVolume(100+ypos);
};
"
))
# not always required for *movie* in php but...
@movie.next_frame

@movie.save("swfscriptedsound.swf",9)
