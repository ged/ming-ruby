#!/usr/bin/ruby
#
# fonts.rb
# original is Brinkster http://www16.brinkster.com
# $Log: fonts.rb,v $
# Revision 1.1  2007/12/28 13:41:24  baribal
# *** empty log message ***
#
# Revision 1.0  2006/12/26 13:29:22  pawel 
#

require 'ming/ming'
include Ming

set_scale(20.00000)
use_SWF_version(6)

movie = SWFMovie.new
movie.set_dimension(550, 500);
movie.set_background(0xcc,0xcc,0xcc );
 
def maketextfield (name,font,str)
txtfield = SWFTextField.new(SWFTextField::DRAW_BOX  | SWFTextField::USE_FONT | SWFTextField::MULTILINE | SWFTextField::WORDWRAP)
txtfield.set_height(18)
txtfield.set_bounds(200,30)
txtfield.set_name(name)
txtfield.set_color(0xff, 0x33, 0x33)
txtfield.set_alignment(SWFTextField::ALIGN_JUSTIFY)
txtfield.set_font(SWFFont.new(font))
txtfield.add_chars(" abcdefghijklmnoprstuwxyzABCDEFGHIJKLMNOPRSTUVWXYZ0123456789")
txtfield.add_string(str)

txtfield
end

txtarial = maketextfield("txtarial","../common/test.ttf","Test TTF")
txt = movie.add(txtarial)
txt.move_to(50,50)

txttest = maketextfield("txttest","../common/Verdana.fdb","Verdana FDB")
txt2 = movie.add(txttest)
txt2.move_to(50,100)

strAction = "
// function to make a textfield using actionscript
function maketextfieldAS(x,y,vfont) {
++depth;
_root.createTextField('AStxt'+depth,depth,x,y,200,30);
myformat = new TextFormat();
myformat.color = 0xff0000;
myformat.bold = true;
myformat.font = vfont;
myformat.size = 18;
with (_root['AStxt'+depth]){
multiline = true;
wordWrap = true;
border = true;
type = 'input';
embedFonts = false;
text = vfont;
setTextFormat(myformat);
}
return _root['AStxt'+depth];
};
// it seems that once a font is embedded using ming 
// the font is then available to textfields created with AS
dyntxtboxAS=maketextfieldAS(300,50,'Test');
dyntxtboxAS=maketextfieldAS(300,100,'Verdana');
"

movie.add(SWFAction.new(strAction))

movie.save("fonts.swf",9)
