#!/usr/bin/ruby

require 'ming/ming'
include Ming

use_SWF_version(8)
set_scale(20.00000000)

@m = SWFMovie.new
@m.set_dimension(320, 240)

@xml = "<rdf:RDF xmlns:rdf=http://www.w3.org/1999/02/22-rdf-syntax-ns#></rdf:RDF>";

@m.add_metadata(@xml)

@m.save("addMetadata.swf")