#!/usr/bin/ruby
# Flash 8 bevel - move the mouse
# code by gazb : gazb dot ming at NOSPAM gmail dot com
# March 2007
# http://www16.brinkster.com/gazb/ming/
# Ruby code by Pawel Karwowski pkarwow at fastmail dot fm

require 'ming/ming'
include Ming

set_scale(20.0)
use_SWF_version(8)

@movie = SWFMovie.new
@movie.set_rate(31)
@movie.set_dimension(550,400)
@movie.set_background(0x55,0xaa,0xee)

# create a box
@boxwidth=200
@boxheight=200

@box = SWFShape.new 
@box.set_right_fill(@box.add_fill(255,0,0))
@box.draw_line(@boxwidth,0)
@box.draw_line(0,@boxheight)
@box.draw_line(-@boxwidth,0) 
@box.draw_line(0,-@boxheight) 
@sp = SWFMovieClip.new
@sp.add(@box)
@sp.next_frame
@f1=@movie.add(@sp)
@f1.set_name("box")

# create an actionscript string
@strAction="


// create references to classes


box._x=Stage.width/2-box._width/2;
box._y=Stage.height/2-box._height/2;

box.cacheAsBitmap = true;

var listener = new Object();
listener.box = box;
listener.onMouseMove = function() {
    var xPercent = (Stage.width/2)-_xmouse;
    var yPercent = (Stage.height/2)-_ymouse;
	var ffds=flash.filters.DropShadowFilter;
	var filter = new ffds(xPercent, yPercent, 0x333333, 0.8, 8, 8, 1, 3, false, false, false);

    var filterArray =[];
    filterArray.push(filter);
    this.box.filters = filterArray;
};

Mouse.addListener(listener);
listener.onMouseMove();



"

# write actionscript string to root frame #1
@movie.add(SWFAction.new(@strAction))

@movie.save("dropshadowfilter.swf",9)
