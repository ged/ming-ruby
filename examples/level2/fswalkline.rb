#!/usr/bin/ruby
#
# fswalkline.rb
# original script on http;//www.redhot.pepper.jp/ming_php
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.05.07
#

require 'ming/ming'
include Ming

use_SWF_version(6) # works only with version 6

set_scale(20.0)
m = SWFMovie.new
m.set_dimension(550,400)
m.set_rate(30)
m.set_background(0xff, 0xff, 0xff)


str="RedHot.Pepper.JP"
font="../common/Verdana.fdb"
f = SWFFont.new(font)
t = SWFText.new
 t.set_font(f)
 t.set_color(0xff, 0x33, 0x33)
 t.set_height(20)
 t.set_spacing(1.0)
 t.add_string(str)
i = m.add(t)

i.move_to(t.get_width(str)/2+100, t.get_ascent()/2)
 
m.add(SWFAction.new("
createEmptyMovieClip('linie', 100); //100
createEmptyMovieClip('schatten', 99); //99
linie._x = 0;
linie._y = 0;
schatten._x = 20;
schatten._y = 20;
x1as = Math.random() * 0.1;
y1as = Math.random() * 0.1;
x2as = Math.random() * 0.1;
y2as = Math.random() * 0.1;
x3as = Math.random() * 0.1;
y3as = Math.random() * 0.1;
x4as = Math.random() * 0.1;
y4as = Math.random() * 0.1;
s = 150;
linie.onEnterFrame = function() {
	x1 = (Math.sin((x1a = x1a + x1as)) * s) + 200;
	y1 = (Math.sin((y1a = y1a + y1as)) * s) + 100;
	x2 = (Math.sin((x2a = x2a + x2as)) * s) + 270;
	y2 = (Math.sin((y2a = y2a + y2as)) * s) + 200;
	x3 = (Math.sin((x3a = x3a + x3as)) * s) + 370;
	y3 = (Math.sin((y3a = y3a + y3as)) * s) + 300;
	x4 = (Math.sin((x4a = x4a + x4as)) * s) + 170;
	y4 = (Math.sin((y4a = y4a + y4as)) * s) + 300;
	linie.clear();
	linie.lineStyle(30, 0x0000000, 100);
	linie.moveTo(x1, y1);
	linie.curveTo(x2, y2, x3, y3);
	linie.curveTo(x4, y4, x1, y1);
	schatten.clear();
	schatten.lineStyle(40, 0, 40);
	schatten.moveTo(x1, y1);
	schatten.curveTo(x2, y2, x3, y3);
	schatten.curveTo(x4, y4, x1, y1);
};

mc.swapDepths(101); //101

"))

m.save("fswalkline.swf")
