#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(8)
set_scale(20.00000000)

@m = SWFMovie.new
@m.set_dimension(320, 240)

@m.set_script_limits(10, 11)

@m.save("setScriptLimits.swf")
