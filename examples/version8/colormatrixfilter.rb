#!/usr/bin/ruby
# Flash 8 color matrix filter - move the mouse
# code by gazb : gazb dot ming at NOSPAM gmail dot com
# March 2007
# http://www16.brinkster.com/gazb/ming/

require 'ming/ming'
include Ming

set_scale(20.0)
use_SWF_version(8)
@movie = SWFMovie.new
@movie.set_rate(31)
@movie.set_dimension(550,400)
@movie.set_background(0xee, 0xdc, 0x45)


# create a image
@img = SWFBitmap.new("../common/picture.jpg")
@sp = SWFMovieClip.new 
@sp.add(@img)
@sp.next_frame
@f1 = @movie.add(@sp)
@f1.set_name("image")

@movie.add(SWFAction.new("

// create references to classes
ffbf=flash.filters.BitmapFilter;
ffcmf=flash.filters.ColorMatrixFilter;

image._x=Stage.width/2-image._width/2;
image._y=Stage.height/2-image._height/2;

image.cacheAsBitmap = true;

var listener = new Object();
listener.image = image;
listener.onMouseMove = function() {
    var xPercent = 1 - (_xmouse/Stage.width);
    var yPercent = 1 - (_ymouse/Stage.height);
    var matrix = new Array();
    matrix = matrix.concat([yPercent, 0, 0, 0, 0]); // red
    matrix = matrix.concat([0, xPercent, 0, 0, 0]); // green
    matrix = matrix.concat([0, 0, xPercent, 0, 0]); // blue
    matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha

    var filter = new ffcmf(matrix);
    image.filters = new Array(filter);
};

Mouse.addListener(listener);
listener.onMouseMove();

"
));

@movie.save("colormatrixfilter.swf",9)
