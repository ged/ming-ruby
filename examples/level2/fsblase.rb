#!/usr/bin/ruby
#
# fsblase.rb
# original script on http;//www.redhot.pepper.jp/ming_php
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.05.07
#

require 'ming/ming'
include Ming

use_SWF_version(7)

set_scale(20.000000)
m = SWFMovie.new
m.set_dimension(550,400)
m.set_rate(31)
m.set_background(0x00, 0x33, 0xcc)

bitmapshape = SWFBitmap.new("../common/alpha.dbl")

bitmapsprite = SWFMovieClip.new
f1 = bitmapsprite.add(bitmapshape)
bitmapsprite.next_frame

m.add_export(bitmapsprite, "blase")
m.write_exports

str="RedHot.Pepper.JP"
font="../common/Verdana.fdb"
f = SWFFont.new(font)
t = SWFText.new
t.set_font(f)
t.set_color(0xff, 0xd7, 0x00)
t.set_height(16)
t.set_spacing(1.0)
t.add_string(str)
i = m.add(t)
i.move_to(275-t.get_width(str)/2, 200+t.get_ascent()/2)

strAction = "
function setzeBlasen(obj, tiefe, xPos, yPos, anzahl, zHoehe, zBreite,
Hoehe, Breite) {
	this.createEmptyMovieClip(obj,tiefe);
	this[obj]._x = xPos;
	this[obj]._y = yPos;
	for (i = 1; i <= anzahl; i++) {
		this[obj].attachMovie('blase', 'blump' + i, tiefe + i);
		this[obj]['blump' + i].geschw = random(7) + 5;
		this[obj]['blump' + i].wert = random(4);
		this[obj]['blump' + i].richtung = -1;
		this[obj]['blump' + i].ZS = random(50) + 10;
		this[obj]['blump' + i]._xscale = this[obj]['blump' + i].ZS;
		this[obj]['blump' + i]._yscale = this[obj]['blump' + i].ZS;
		this[obj]['blump' + i]._y = random(zHoehe);
		this[obj]['blump' + i]._x = random(zBreite);
		this[obj]['blump' + i].onEnterFrame = function() {
			this._y -= this.geschw;
			this._x -= this.wert;
			this.wert += this.richtung;
			if (this._y <= 0) {
				this._y = Hoehe;
				this.wert = random(4);
				this.geschw = random(7) + 5;
				this.ZS = random(50) + 10;
			}
			if (this._x <= 0) {
				this._x = Breite - this._width;
			}
			if (this._x >= Breite) {
				this._x = 0 + this._width;
			}
			if (this.wert < -3) {
				this.richtung = 1; //+1
			}
			if (this.wert > 3) {
				this.richtung = -1;
			}
		};
	}	
};

setzeBlasen('raum', 1, 100, 0, 30, 400, 550, 400, 50);
setzeBlasen('raum2', 2, 250, 0, 30, 400, 550, 400, 50);
setzeBlasen('raum3', 3, 400, 0, 30, 400, 550, 400, 50);
";

m.add(SWFAction.new(strAction))

m.save("fsblase.swf")
