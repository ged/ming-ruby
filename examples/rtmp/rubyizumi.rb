#!/usr/bin/ruby

require'ming/ming'
include Ming

set_scale(20.000000)
use_SWF_version(9)


@m= SWFMovie.new
@m.set_dimension(200, 150)
@m.set_background(0x33, 0x43, 0x66)
@m.set_rate(12)


@stream= SWFVideoStream.new
@stream.set_dimension(200, 150)
@i = @m.add(@stream)
@i.set_name("video")
@i.move_to(0, 0)

@action = SWFAction.new("

    nc=new NetConnection();
    nc.connect('rtmp://localhost'); 			    			    

    nc.onStatus = function(infoObj) {
		
	switch (infoObj.code) {
	    case 'NetConnection.Connect.Success':
				
	    NewStream=new NetStream(nc);

	    video.attachVideo(NewStream);
	    NewStream.setBufferTime(10);
	    NewStream.play(\"backcountry_bombshells_4min_HD_h264.mp4\");				
	    break;
			    
	    case 'NetConnection.Connect.Failed':
	    trace('aa');
	    break;
				    
	    case 'NetConnection.Connect.Rejected':
	    trace('bb');				
	    break;
			    
	};
			
    };
")
@m.add(@action)

@m.save("rubyizumi.swf")
