#!/usr/bin/ruby
#
# browserfonts.rb 
# original is Brinkster http://www16.brinkster.com 
# $Log: browserfonts.rb,v $
# Revision 1.1  2007/12/28 13:41:23  baribal
# *** empty log message ***
#
# Revision 1.0  2006/12/26 13:30:22 pawel 
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
txtfield.set_font(SWFBrowserFont.new(font))
txtfield.add_chars(" abcdefghijklmnoprstuwxyzABCDEFGHIJKLMNOPRSTUWXYZ0123456789")
txtfield.add_string(str)

txtfield
end

txtsans = maketextfield("txtsans","_sans","_sans")
txt = movie.add(txtsans)
txt.move_to(50,50)

txtserif = maketextfield("txtserif","_serif","_serif")
txt2 = movie.add(txtserif)
txt2.move_to(50,100)

txtcourier = maketextfield("txtcourier","courier","courier")
txt3 = movie.add(txtcourier)
txt3.move_to(50,150)

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
dyntxtboxAS=maketextfieldAS(300,50,'_sans');
dyntxtboxAS=maketextfieldAS(300,100,'_serif');
dyntxtboxAS=maketextfieldAS(300,150,'courier');
"

movie.add(SWFAction.new(strAction))

movie.save("browserfonts.swf",9)
