#!/usr/bin/ruby
#
# sketchpad.rb
# original script by Brinkster http://www.16brinkster.com
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.25
#

require 'ming/ming'
include Ming

use_SWF_version(6)

set_scale(20.00000)
m = SWFMovie.new
m.set_dimension(600,400)
m.set_rate(31)
m.set_background(0xcc, 0xcc, 0xcc)


strAction = "

sketchpad = {
onMouseDown: function () {
draw=true;
moveTo(_xmouse, _ymouse);
},
onMouseUp: function () {
draw=false;
},
onMouseMove: function () {
if (draw) {
lineStyle(9, 255, 100);
lineTo(_xmouse, _ymouse);
}
},
onKeyDown: function () {
clear();
}
};

Mouse.addListener(sketchpad);
Key.addListener(sketchpad);
"

m.add(SWFAction.new(strAction))
m.save("sketchpad.swf")
