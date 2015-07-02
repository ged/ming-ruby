#!/usr/bin/ruby
#
# onclipevent2.rb
# original script by Brinkster http://www16.brinkster.com/gazb/ming
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl 
# Revision 1.0 2007/05/12
#

require 'ming/ming'
include Ming

set_scale(20.0000000)
use_SWF_version(6) # works well with version 6

@m = SWFMovie.new
@m.set_background(0xcc, 0xcc, 0xcc)
@m.set_dimension(550, 400)
@m.set_rate(12)

@s= SWFShape.new
@s.set_right_fill(@s.add_fill(255,255,255))
@s.move_pen_to(-50,-50)
@s.draw_line(50,-20) 
@s.draw_line(50,20)
@s.draw_line(20,50)  
@s.draw_line(-20,50)
@s.draw_line(-50,20)  
@s.draw_line(-50,-20) 
@s.draw_line(-20,-50)  
@s.draw_line(20,-50)

@sp= SWFMovieClip.new
@f1 = @sp.add(@s)
@sp.next_frame
@clip=@m.add(@sp)
@clip.move_to(275,200)


@sx= SWFShape.new
@sx.set_right_fill(@sx.add_fill(255,255,255))
@sx.move_pen_to(150,150)
@sx.draw_line(50,-20) 
@sx.draw_line(50,20)
@sx.draw_line(20,50)  
@sx.draw_line(-20,50)
@sx.draw_line(-50,20)  
@sx.draw_line(-50,-20) 
@sx.draw_line(-20,-50)  
@sx.draw_line(20,-50)

@spx= SWFMovieClip.new
@f2 = @spx.add(@sx)
@spx.next_frame

@ab = @clip.get_rotation
@ac = @clip.get_position
@acx = @ac[0]
@acy = @ac[1]
@af = @clip.get_scale
@afx = @af[0]
@afy = @af[1]

@clip1=@m.add(@spx)
@clip1.move_to(@acx+75,@acy+100)
@clip1.scale_to(@afx/5, @afy/3)
@clip1.rotate_to(-@ab)

@clip.add_action(SWFAction.new("loadVariables('colvar.txt',this);dir=5;function run(){this._rotation+=dir;};"),SWFAction::ON_LOAD)
@clip.add_action(SWFAction.new("run();"), SWFAction::ENTER_FRAME)
@clip.add_action(SWFAction.new("this.startDrag('');"), SWFAction::MOUSE_DOWN)
@clip.add_action(SWFAction.new("stopDrag();"), SWFAction::MOUSE_UP)
@clip.add_action(SWFAction.new("dir=-5;"), SWFAction::KEY_DOWN)
@clip.add_action(SWFAction.new("dir=5;"), SWFAction::KEY_UP)
@clip.add_action(SWFAction.new("oldX=X;oldY=Y;Y=_parent._ymouse;X=_parent._xmouse;_x+=(oldX-X)/50;_y+=(oldY-Y)/50;"),SWFAction::MOUSE_MOVE)
@clip.add_action(SWFAction.new("col=new Color(this);col.SetRGB(clipcolor);"), SWFAction::DATA)


@clip1.add_action(SWFAction.new("loadVariables('colvar.txt',this);dir=5;function run(){this._rotation+=dir;};"),SWFAction::ON_LOAD)
@clip1.add_action(SWFAction.new("run();oldX=#@acx;oldY=#@acy;Y=_parent._ymouse;X=_parent._xmouse;_x+=(oldX-X)/50;_y+=(oldY-Y)/50;"), SWFAction::ENTER_FRAME)
@clip1.add_action(SWFAction.new("dir=-5;"), SWFAction::KEY_DOWN)
@clip1.add_action(SWFAction.new("dir=5;"), SWFAction::KEY_UP)
@clip1.add_action(SWFAction.new("col=new Color(this);col.SetRGB(clipcolor);"), SWFAction::DATA)

@m.save("onclipevent2.swf")
