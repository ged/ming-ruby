#!/usr/bin/ruby
#
# text_effect2.rb
# original script by Sham Bhangal in Flash hacks book.
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.27
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(7)

movie = SWFMovie.new

movie.set_dimension(500,450)
movie.set_background(0xcc,0xcc,0xcc)
movie.set_rate(31)

t = SWFText.new
t.set_font(SWFFont.new("../common/Verdana.fdb"))
t.add_string(" abcdefghijklmnoprstuwvxyzT.")
i = movie.add(t)

strA = SWFAction.new("
this.createTextField('AStxt',depth++,0,0,40,60);
this.AStxt.multiline = true;
this.AStxt.wordWrap = true;
this.AStxt.border = false;
this.AStxt.embedFonts = false;
this.AStxt.type = 'dynamic';
//this.AStxt.text = 'm';

myformat = new TextFormat();
myformat.font = '_sans';
myformat.size = 14;
this.AStxt.setTextFormat(myformat);
")

holder = SWFMovieClip.new
f1 = holder.add(strA)
holder.next_frame
movie.add_export(holder, 'letter')
movie.write_exports

strAction = "
_global.i=0;
myformat1 = new TextFormat();
myformat1.size = 22;
myformat1.bold = true;
myformat1.font = '_sans';
myformat1.color = 0x888000;

this.onEnterFrame = function() {
tekst = 'Super discount! ';

this.attachMovie('letter','dot'+ i, i);
var dot = this['dot'+ i];
for (j=0; j<tekst.length; j++) {
this['dot'+ j].AStxt.setTextFormat(myformat1);
};

this['dot'+ _global.i].AStxt.text += tekst.substr(_global.i, 1);

dot.x = i*20;
dot.y = 100;

dot._x = dot.x + (random(100)-50);
dot._y = dot.y + (random(100)-50);
dot.speed = 5;

dot.onEnterFrame = function() {
var sx = (this._x-this.x)/this.speed;
var sy = (this._y-this.y)/this.speed;
this._x-=sx;
this._y-=sy;
};

//dot._x += myformat1.getTextExtent(this['dot'+ _global.i].AStxt.text).width+40;

if (i == tekst.length) {
   delete i;
   this.onEnterFrame = undefined;
   }
_global.i=i++;
};
"
movie.add(SWFAction.new(strAction))
movie.save("text_effect2.swf")
