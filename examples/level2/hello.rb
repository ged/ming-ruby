#!/usr/bin/ruby
# http://www.kumamushi.org/~k/ming

require 'ming/ming'
include Ming

m = SWFMovie.new
f = SWFBrowserFont.new('_serif')
t = SWFTextField.new
t.set_font(f)
t.add_string('Hello, world!')
m.add(t)
m.save('hello.swf')
