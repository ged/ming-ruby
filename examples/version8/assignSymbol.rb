#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(9)
set_scale(20.00000000)

@m = SWFMovie.new
@m.set_dimension(640, 480)

@text = SWFText.new

@font = SWFFont.new("../common/test.ttf")

@m.assign_symbol(@text, "mytext")
@text.set_font(@font)
@text.set_color(0, 0, 0, 0xff)
@text.set_height(20)
@text.move_to(100, 100)
@text.add_string( "The quick brown fox jumps over the lazy dog. 1234567890")

@m.add(@text)
@m.next_frame


@m.save("assignSymbol.swf")
