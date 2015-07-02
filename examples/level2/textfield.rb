#!/usr/bin/ruby
#
# textfield.rb
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

def maketextfield (name,str)
txtfield = SWFTextField.new(SWFTextField::DRAW_BOX  | SWFTextField::USE_FONT | SWFTextField::MULTILINE | SWFTextField::WORDWRAP)
txtfield.set_height(14)
txtfield.set_bounds(600,330)
txtfield.set_name(name)
txtfield.set_color(0x00, 0x55, 0x55)
txtfield.set_alignment(SWFTextField::ALIGN_JUSTIFY)
txtfield.set_font(SWFFont.new("../common/Verdana.fdb"))
txtfield.add_chars(" abcdefghijklmnoprstuwxyzABCDEFGHIJKLMNOPRSTUWXYZ0123456789")
txtfield.add_string(str)
return txtfield
end

txtxml = maketextfield("txtxml", "\nThis is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text.\n\n")
txt=m.add(txtxml)
txt.move_to(20,50)

m.save("textfield.swf",9)
