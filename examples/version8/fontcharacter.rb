#!/usr/bin/ruby
#
# fontcharacter,rb
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2007.12.20
#

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(9)

m = SWFMovie.new
m.set_background(0xff, 0xff, 0xff)
m.set_dimension(550,400)
m.set_rate(5)

f = SWFFont.new("../common/Verdana.fdb")

fc = m.add_font(f)
fc.add_all_chars

strAction = "
// make textfield
createTextField('mytext',2,-100,100,560,100);
with (mytext){ 
multiline = true; wordWrap = true; border = true; embedFonts = true;
text='This is an example of FontCharacter class. Embedded font is used in AS generated textfield.';
type = 'input';
}

// make textformat
myformat = new TextFormat();
myformat.color = 0x000ff0;
myformat.font = 'Verdana';
myformat.bold = true;
myformat.size = 22;
mytext.setTextFormat(myformat);
"

m.add(SWFAction.new(strAction))

m.save("fontcharacter.swf")
