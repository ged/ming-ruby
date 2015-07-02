#!/usr/bin/ruby
#
# fsin.rb
# original script on http;//www.redhot.pepper.jp/ming_php
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.05.07
#

require 'ming/ming'
include Ming

use_SWF_version(6)

set_scale(20.0)
m = SWFMovie.new
m.set_dimension(550,400)
m.set_rate(30)
m.set_background(0x00, 0x00, 0x00)

m.add(SWFAction.new("
function vorlage(pName, pXClips, pYClips, pXPos, pYPos, pTempo, pDicke,
pFarbe, pXFaktor, pYFaktor, pBFaktor) {
	this.objName = pName;
	this.xClips = pXClips;
	this.yClips = pYClips;
	this.xPos = pXPos;
	this.yPos = pYPos;
	this.tempo = pTempo;
	this.dicke = pDicke;
	this.farbe = pFarbe;
	this.xFaktor = pXFaktor;
	this.yFaktor = pYFaktor;
	this.bFaktor = pBFaktor;
	this.erzeugen = function() {
		for (x = 0; x < this.xClips; x++) {
			for (y = 0; y < this.yClips; y++) {
				_root.cname = (x + this.objName) + y;
				_root.createEmptyMovieClip(cname, i++);
				_root[cname].lineStyle(this.dicke, this.farbe, 100);
				_root[cname].lineTo(0.5, 1.5);
				_root[cname].cx = (this.xPos * (x - y)) + (Stage.width / 2);
				_root[cname].cy = ((this.yPos * (x + y)) / this.yFaktor) +
(Stage.height / 2);
				_root[cname].nn = Math.sin(x / this.xFaktor) + Math.sin(y /
this.yFaktor);
				this.wellengang = function(src, xPos, yPos, faktor) {
					src._x = src.cx + (xPos * Math.sin(src.nn));
					src._y = src.cy + (yPos * Math.sin(src.nn));
					src._alpha = 50 + (25 * Math.sin(src.nn));
					src.nn = src.nn + faktor;
				};
				setInterval(this.wellengang, this.tempo, _root[cname], this.xPos,
this.yPos, this.bFaktor);
			}
		}
		delete i;
		delete cname;
		delete x;
		delete y;
	};
}

// Welle (Objekte erzeugen und Ausgangswerte festelegen)
meineWelle = new vorlage('clip', 15, 15, 10, 10, 20, 2, 0xffffff, 2.5, 2.5,
0.2);

// Funktion erzeugen aufrufen um die Welle optisch umzusetzen
meineWelle.erzeugen();

"))

m.save("fsin.swf")
