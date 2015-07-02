#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(9)
set_scale(20.00000000)

@m = SWFMovie.new
@m.set_dimension(640, 480)

0.upto(10) do
 @m.next_frame
end

@m.define_scene(0, "test0")
@m.define_scene(5, "test1")

@m.save("defineScene.swf")
