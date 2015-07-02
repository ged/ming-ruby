#!/usr/bin/ruby
# rubygut.2 author Pawel


require 'ming/ming'
include Ming

m = SWFMovie.new
m.set_dimension(640, 480)

list = m.methods
puts list
puts
puts "Rubyguts:  "
puts
puts m.object_id
puts m.taint
puts m.class
puts m.frozen?
puts m.hash
puts m.to_s
puts m.nil?

m.save("rubygut2.swf")
