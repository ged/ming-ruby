#!/usr/bin/ruby
#
# dot.rb
# original script by Sham Bhangal in Flash hacks book.
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.27
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6) # works only with version 6

@movie = SWFMovie.new
@movie.set_dimension(500,400)
@movie.set_background(0xff,0xff,0xff)
@movie.set_rate(31)

  @f = open("./aa/DrawingMethods.as", "r")
  @ary = @f.readlines
       @as = SWFAction.new(@ary.to_s)
       @movie.add(@as)
  @f.close

  @g = open("./AScode/Dot.as", "r")
  @ary2 = @g.readlines
       @as2 = SWFAction.new(@ary2.to_s)
       @movie.add(@as2)
  @g.close

@action = SWFAction.new("
this.createEmptyMovieClip('square_mc', 1);
square_mc.lineStyle(1, 0x000000, 100);
square_mc.beginFill(0x000000);
square_mc.drawRectangle(10, 10);
square_mc.endFill();
removeMe = function() {
  clearInterval(countDown);
  this.removeMovieClip();
};
var countDown = setInterval(this, 'removeMe', timer);
")


@holder = SWFMovieClip.new
 @f1 = @holder.add(@action)
@holder.next_frame
@movie.add_export(@holder, 'DotSymbol')

@movie.add(@action)
@movie.save("dot.swf")
