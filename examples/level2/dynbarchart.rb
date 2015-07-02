#!/usr/bin/ruby
#
# dynbarchart.rb
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.05.07
#

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(6) #works only with version(6)

m = SWFMovie.new
m.set_background(0xcc, 0xcc, 0xcc)
m.set_dimension(550,400)
m.set_rate(31)

strAction = "
// make bar
createEmptyMovieClip('bar', 1);
with(bar){
beginFill(255, 90); moveTo(0, 0); lineTo(0, -100); lineTo(40, -100);
lineTo(40, 0); lineTo(0, 0); endFill(); _x=-500; _y=-500;
}

// duplicate bar
for(i=1;i<6;i++) {
bar.duplicateMovieClip('bar'+i,100+i);
with(_root['bar'+i]){
_y=110; _x=110+i*42;
_yscale=0;
}
var col=new Color(_root['bar'+i]);
col.setRGB(random(0x666666));
};

// make textfield
createTextField('mytext',2,10,10,360,100);
with (mytext){ 
multiline = true; wordWrap = true; border = true;
text='loading data every fifteen seconds.....';
type = 'dynamic';
}

// make textformat
myformat = new TextFormat();
myformat.color = 0x000ff0;
myformat.font = '_sans';
myformat.bold = true;
myformat.italic = true;
myformat.size = 12;
mytext.setTextFormat(myformat);

// make bars rescale
onEnterFrame=function() {
for(i=1;i<6;i++) {
var disty=lv['var'+i]-this['bar'+i]._yscale;
var movey=disty/5;
this['bar'+i]._yscale+=movey;
}};

// make loadVars
lv = new LoadVars();
lv.onLoad = function(success) {
if(success) {
mytext.text='loaded= ' + success;
for(i=1;i<6;i++) { mytext.text+='\n this.var'+i+'=' + this['var'+i]; }
mytext.setTextFormat(myformat);  // hack
}else { mytext.text='failed'; }
};

// make callback
callback = function()  {
counter=++counter%3;
lv.load('vars'+counter+'.txt');
};
counter=0;
lv.load('vars'+counter+'.txt');

// set callback
intervalID = setInterval( callback, 3000 ); 
"

m.add(SWFAction.new(strAction))
m.save("dynbarchart.swf")
