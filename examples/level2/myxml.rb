#!/usr/bin/ruby
#
# myxml.rb
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006/05/07
#

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(7)

m = SWFMovie.new
m.set_background(0xff, 0xff, 0xff)
m.set_dimension(650, 440)
m.set_rate(31)


def maketextfield (name,font,str)
txtfield = SWFTextField.new(SWFTextField::DRAW_BOX  | SWFTextField::NO_EDIT | SWFTextField::NO_SELECT | SWFTextField::MULTILINE | SWFTextField::WORDWRAP)
txtfield.set_height(14)
txtfield.set_bounds(600,330)
txtfield.set_name(name)
txtfield.set_color(0x00, 0x55, 0x55)
txtfield.set_font(SWFBrowserFont.new(font))
txtfield.add_string(str)
return txtfield
end


txtxml = maketextfield("txtxml", "Verdana", "\nThis is an example text: we use Verdana BrowserFont\n\n")
txt=m.add(txtxml)
txt.move_to(20,50)


strAction = "
System.useCodepage = true;

myXML = new XML();

myXML.contentType = UTF-8;
myXML.onLoad = handleload;
myXML.load('books.xml');
if (!success) {
txtxml.text = 'fail';
}

function handleload (success) {
if (success) {
var root= this.firstChild;
while(root.nodeName!='html') {
root=root.nextSibling;
}
for(var i=0;i<root.childNodes.length;i++) {
txtxml+= ('head: '+root.childNodes[i]+'\n');
}
}
}
"
m.add(SWFAction.new(strAction))
m.save("myxml.swf",9)
