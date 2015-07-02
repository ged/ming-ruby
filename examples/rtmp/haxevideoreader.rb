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
@stream.set_dimension(100, 75)
@i = @m.add(@stream)
@i.set_name("video")
@i.move_to(50, 20)

@action = SWFAction.new("

    nc=new NetConnection();
    nc.connect('rtmp://localhost'); 			    			    

	nc.onStatus = function(infoObj) {
		
	    switch (infoObj.code) {
	    case 'NetConnection.Connect.Success':
				
	    NewStream=new NetStream(nc);
	    video.attachVideo(NewStream);
	    NewStream.play('myRecord.flv');				
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

@m.save("haxevideoreader.swf")
