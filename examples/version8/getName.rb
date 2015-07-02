#!/usr/bin/ruby
#
# getname.rb
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2008.02.22
#

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(9)

m = SWFMovie.new
m.set_background(0xff, 0xff, 0xff)
m.set_dimension(550,400)
m.set_rate(5)

@f = SWFFont.new("../common/test.ttf")

@a = @f.get_name

@fc = m.add_font(@f)

@fc.add_chars("abcdefghijklmnoprstuwxyzASTEFCN!_ .")


strAction = "

// make textfield
createTextField('mytext',2,-100,100,560,150);
with (mytext){ 
multiline = true; wordWrap = true; border = true; embedFonts= true;
text='This is an example of FontCharacter class. Embedded font is used in AS generated textfield. Name of the font is read with ruby get_name method!';
type = 'dynamic';
}

// make textformat
myformat = new TextFormat();
myformat.color = 0x000ff0;
myformat.font = '#{@a}';
myformat.bold = false;
myformat.size = 22;
mytext.setTextFormat(myformat);
"

m.add(SWFAction.new(strAction))

m.save("getname.swf")
