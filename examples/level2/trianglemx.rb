#!/usr/bin/ruby
# trianglemx.rb -k
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006.12.27
#

require 'ming/ming'
include Ming

set_scale(20.000000)
use_SWF_version(6)

movie = SWFMovie.new
movie.set_dimension(550,400)
movie.set_background(0xcc, 0xcc, 0xcc )
movie.set_rate(31)

strAction = "
_root.createEmptyMovieClip( 'triangle', 1 );
with ( _root.triangle ) {
lineStyle( 5, 0xff00ff, 100 );
beginFill(128,105,98);
moveTo( 200, 200 );
lineTo( 300,300 ); 
lineTo( 100, 300 );
lineTo( 200, 200 );
}
"

movie.add(SWFAction.new(strAction))
movie.save("trianglemx.swf")
