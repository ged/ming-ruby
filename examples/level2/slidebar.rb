#!/usr/bin/ruby
# slidebar.rb -k
# original script on http;//www.redhot.pepper.jp/ming_php
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
#

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(6) # works well with version 6

movie = SWFMovie.new
movie.set_dimension(514, 350)
movie.set_background(0x00,0xdd,0xbb)
movie.set_rate(31)

fishshape = SWFBitmap.new("../common/backyard1.jpg")
fishsprite= SWFMovieClip.new
f2 = fishsprite.add(fishshape)
fishsprite.next_frame
fishclip=movie.add(fishsprite)
fishclip.move_to(0,0)

bitmapshape = SWFBitmap.new("../common/picture.jpg")
bitmapsprite= SWFMovieClip.new
f1 = bitmapsprite.add(bitmapshape)
bitmapsprite.next_frame
bitmapclip=movie.add(bitmapsprite)
bitmapclip.set_name("bitmapmc")

squareshape = SWFShape.new
squareshape.set_right_fill(squareshape.add_fill(255,255,255)) 
squareshape.draw_line(150,0)
squareshape.draw_line(0,3)
squareshape.draw_line(-150,0)
squareshape.draw_line(0,-3)
squaresymbol=movie.add(squareshape)
squaresymbol.move_to(180,318)

squareshape= SWFShape.new 
squareshape.set_right_fill(squareshape.add_fill(255,0,0)) 
squareshape.draw_line(20,0)
squareshape.draw_line(0,40) 
squareshape.draw_line(-20,0)
squareshape.draw_line(0,-40) 
slideknob= SWFMovieClip.new
f1 = slideknob.add(squareshape)
slideknob.next_frame
knobclip=movie.add(slideknob)
knobclip.set_name("knob_mc")

strAction = "
bitmapmc._x = 0;
bitmapmc._y = 0;

knob_mc._x = 250;
knob_mc._y = 300;
knob_mc.ratio = 50;

knob_mc.onPress = function ()
{
    this.startDrag(true, 180, this._y, 310, this._y);
    this.onEnterFrame = function ()
    {
        this.ratio = Math.round((this._x - 180)*100/130);
    };
};

knob_mc.onRelease = knob_mc.onreleaseOutside = stopDrag;

bitmapmc.onEnterFrame=function(){
  this._alpha = knob_mc.ratio;
};
"
movie.add(SWFAction.new(strAction))

movie.save("slidebar.swf",9)
