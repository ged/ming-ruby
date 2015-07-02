#!/usr/bin/ruby

# SWFMing_T_Scrollbar mixin module for Ming 0.4.
# Version 0.39 for Ruby.
# based upon Pipey's code and SWFTools scrollbar code
# Author Pawel Karwowski pkarwow at fastmail dot fm

module SWFMing_T_Scrollbar

@PATH = "/usr/lib/ruby/site_ruby/1.8/ming/pictures"

def self.new(instance, depth, a, b, c, d, border, embedFonts, textadd)

@instance = instance
@depth = depth
@a = a
@b = b
@c = c
@d = d
@border = border
@embedFonts = embedFonts
@textadd = textadd

@arrow_up_inactive = SWFShape.new
@dbl1 = SWFBitmap.new("#{@PATH}/arrow_up_inactive.dbl")
@arrow_up_inactive.set_right_fill(@arrow_up_inactive.add_fill(@dbl1, SWFFill::CLIPPED_BITMAP))
   @arrow_up_inactive.draw_line(@dbl1.get_width, 0)
   @arrow_up_inactive.draw_line(0, @dbl1.get_height)
   @arrow_up_inactive.draw_line(-@dbl1.get_width, 0)
   @arrow_up_inactive.draw_line(0, -@dbl1.get_height)

@arrow_up_active = SWFShape.new
@dbl2 = SWFBitmap.new("#{@PATH}/arrow_up_active.dbl");
@arrow_up_active.set_right_fill(@arrow_up_active.add_fill(@dbl2, SWFFill::CLIPPED_BITMAP))
   @arrow_up_active.draw_line(@dbl2.get_width, 0)
   @arrow_up_active.draw_line(0, @dbl2.get_height)
   @arrow_up_active.draw_line(-@dbl2.get_width, 0)
   @arrow_up_active.draw_line(0, -@dbl2.get_height)

@arrow_down_inactive = SWFShape.new
@dbl3 = SWFBitmap.new("#{@PATH}/arrow_down_inactive.dbl");
@arrow_down_inactive.set_right_fill(@arrow_down_inactive.add_fill(@dbl3, SWFFill::CLIPPED_BITMAP))
   @arrow_down_inactive.draw_line(@dbl3.get_width, 0);
   @arrow_down_inactive.draw_line(0, @dbl3.get_height);
   @arrow_down_inactive.draw_line(-@dbl3.get_width, 0);
   @arrow_down_inactive.draw_line(0, -@dbl3.get_height);

@arrow_down_active = SWFShape.new
@dbl4 = SWFBitmap.new("#{@PATH}/arrow_down_active.dbl")
@arrow_down_active.set_right_fill(@arrow_down_active.add_fill(@dbl4, SWFFill::CLIPPED_BITMAP))
   @arrow_down_active.draw_line(@dbl4.get_width, 0)
   @arrow_down_active.draw_line(0, @dbl4.get_height)
   @arrow_down_active.draw_line(-@dbl4.get_width, 0)
   @arrow_down_active.draw_line(0, -@dbl4.get_height)

@scrollbar_inactive = SWFShape.new
@dbl5 = SWFBitmap.new("#{@PATH}/scrollbar_inactive.dbl")
@scrollbar_inactive.set_right_fill(@scrollbar_inactive.add_fill(@dbl5, SWFFill::CLIPPED_BITMAP))
   @scrollbar_inactive.draw_line(@dbl5.get_width, 0)
   @scrollbar_inactive.draw_line(0, @dbl5.get_height)
   @scrollbar_inactive.draw_line(-@dbl5.get_width, 0)
   @scrollbar_inactive.draw_line(0, -@dbl5.get_height)

@scrollbar_active = SWFShape.new
@dbl6 = SWFBitmap.new("#{@PATH}/scrollbar_active.dbl")
@scrollbar_active.set_right_fill(@scrollbar_active.add_fill(@dbl6, SWFFill::CLIPPED_BITMAP))
   @scrollbar_active.draw_line(@dbl6.get_width, 0)
   @scrollbar_active.draw_line(0, @dbl6.get_height)
   @scrollbar_active.draw_line(-@dbl6.get_width, 0)
   @scrollbar_active.draw_line(0, -@dbl6.get_height)

@backgroundV = SWFShape.new
@dbl8 = SWFBitmap.new("#{@PATH}/backgroundV.dbl")
@backgroundV.set_right_fill(@backgroundV.add_fill(@dbl8, SWFFill::CLIPPED_BITMAP))
   @backgroundV.draw_line(@dbl8.get_width, 0)
   @backgroundV.draw_line(0, @dbl8.get_height)
   @backgroundV.draw_line(-@dbl8.get_width, 0)
   @backgroundV.draw_line(0, -@dbl8.get_height)

@ib = $movie.add(@backgroundV)
  @ib.set_name("BackgroundV")
  @ib.scale_to(1,0.0625*@d)
  @ib.move_to(@a+@c+2,@b)

@backgroundH_gap = SWFShape.new
@dbl9 = SWFBitmap.new("#{@PATH}/backgroundH_gap.dbl")
@backgroundH_gap.set_right_fill(@backgroundH_gap.add_fill(@dbl9, SWFFill::CLIPPED_BITMAP))
   @backgroundH_gap.draw_line(@dbl9.get_width, 0)
   @backgroundH_gap.draw_line(0, @dbl9.get_height)
   @backgroundH_gap.draw_line(-@dbl9.get_width, 0)
   @backgroundH_gap.draw_line(0, -@dbl9.get_height)

@ic = $movie.add(@backgroundH_gap)
  @ic.set_name("BackgroundH_gap")
  @ic.move_to(@a+@c+2,@b)

@backgroundV_gap = SWFShape.new()
@dbl10 = SWFBitmap.new("#{@PATH}/backgroundV_gap.dbl")
@backgroundV_gap.set_right_fill(@backgroundV_gap.add_fill(@dbl10, SWFFill::CLIPPED_BITMAP))
   @backgroundV_gap.draw_line(@dbl10.get_width, 0)
   @backgroundV_gap.draw_line(0, @dbl10.get_height)
   @backgroundV_gap.draw_line(-@dbl10.get_width, 0)
   @backgroundV_gap.draw_line(0, -@dbl10.get_height)

@id = $movie.add(@backgroundV_gap)
  @id.set_name("BackgroundV_gap")
  @id.move_to(@a+@c+2,@b)

@backgroundH_gap2 = SWFShape.new
@dbl11 = SWFBitmap.new("#{@PATH}/backgroundH_gap2.dbl")
@backgroundH_gap2.set_right_fill(@backgroundH_gap2.add_fill(@dbl11, SWFFill::CLIPPED_BITMAP))
   @backgroundH_gap2.draw_line(@dbl10.get_width, 0)
   @backgroundH_gap2.draw_line(0, @dbl10.get_height)
   @backgroundH_gap2.draw_line(-@dbl10.get_width, 0)
   @backgroundH_gap2.draw_line(0, -@dbl10.get_height)

@ie = $movie.add(@backgroundH_gap2)
  @ie.set_name("BackgroundH_gap2")
  @ie.move_to(@a+@c+2,@b)

@backgroundV_gap2 = SWFShape.new
@dbl12 = SWFBitmap.new("#{@PATH}/backgroundV_gap2.dbl")
@backgroundV_gap2.set_right_fill(@backgroundV_gap2.add_fill(@dbl12, SWFFill::CLIPPED_BITMAP))
   @backgroundV_gap2.draw_line(@dbl12.get_width, 0)
   @backgroundV_gap2.draw_line(0, @dbl12.get_height)
   @backgroundV_gap2.draw_line(-@dbl12.get_width, 0)
   @backgroundV_gap2.draw_line(0, -@dbl12.get_height)

@ikf = $movie.add(@backgroundV_gap2)
  @ikf.set_name("BackgroundV_gap2")
  @ikf.move_to(@a+@c+2,@b)

@dragbutton = SWFMovieClip.new
@but = SWFButton.new
  @but.add_character(@scrollbar_inactive, SWFButton::HIT | SWFButton::UP | SWFButton::OVER)
  @but.add_character(@scrollbar_active, SWFButton::HIT | SWFButton::DOWN)
  @but.add_action(SWFAction.new("
  		DragButton#{@instance}._x = #{@a}+#{@c}+3;
		Dragging = true;
		this.startDrag(DragButton#{@instance}, true, _parent.UpButton#{@instance}._y + 16, #{@a}+#{@c}+3, _parent.DownButton#{@instance}._y - 17 , #{@a}+#{@c}+3 );
		Dragging = true;
		idInt_Drag#{@instance} = setInterval(_parent.Revalue#{@instance}, 15);"), SWFButton::MOUSE_DOWN)
  @but.add_action(SWFAction.new("  
  		Dragging = false;
		clearInterval(idInt_Drag#{@instance});
		this.stopDrag();	
		_parent.Revalue#{@instance}();"), SWFButton::MOUSE_UP | SWFButton::MOUSE_UP_OUTSIDE  | SWFButton::DRAG_OUT | SWFButton::DRAG_OVER)
  @dragbutton.add(@but)
  @dragbutton.next_frame

@ir = $movie.add(@dragbutton)
  @ir.set_name("DragButton#{@instance}")
  @ir.move_to(@a+@c+3,@b+16)

@upbutton = SWFButton.new
@upbutton.add_character(@arrow_up_inactive, SWFButton::HIT | SWFButton::UP | SWFButton::OVER)
@upbutton.add_character(@arrow_up_active, SWFButton::HIT | SWFButton::DOWN)
@upbutton.add_action(SWFAction.new("
	Up_pressed#{@instance}();
	function Up_pressed#{@instance}() {
	if (Value#{@instance} > MinValue) {
	Value#{@instance} = Value#{@instance} - Increment;
	}
	if (Value#{@instance} < MinValue) {
	Value#{@instance} = MinValue;
	}
	Reposition#{@instance}();
	}
	idInt_Up_pressed#{@instance} = setInterval(Up_pressed#{@instance}, 100);"), SWFButton::MOUSE_DOWN)
@upbutton.add_action(SWFAction.new("clearInterval(idInt_Up_pressed#{@instance});"), SWFButton::MOUSE_UP | SWFButton::MOUSE_UP_OUTSIDE)

@is=$movie.add(@upbutton)
@is.set_name("UpButton#{@instance}")
@is.move_to(@a+@c+3,@b)

@downbutton = SWFButton.new
@downbutton.add_character(@arrow_down_inactive, SWFButton::HIT | SWFButton::UP | SWFButton::OVER)
@downbutton.add_character(@arrow_down_active, SWFButton::HIT | SWFButton::DOWN)
@downbutton.add_action(SWFAction.new("
	Down_pressed#{@instance}();
	function Down_pressed#{@instance}() {
	if (Value#{@instance} < MaxValue#{@instance}) {
	Value#{@instance} = Value#{@instance} + Increment;
	}
	if (Value#{@instance} > MaxValue#{@instance}) {
	Value#{@instance} = MaxValue#{@instance};
	}
	Reposition#{@instance}();
	}
	idInt_Down_pressed#{@instance} = setInterval(Down_pressed#{@instance}, 100);"), SWFButton::MOUSE_DOWN)
@downbutton.add_action(SWFAction.new("clearInterval(idInt_Down_pressed#{@instance});"), SWFButton::MOUSE_UP |SWFButton::DRAG_OUT | SWFButton::MOUSE_UP_OUTSIDE)

@iw=$movie.add(@downbutton)
@iw.set_name("DownButton#{@instance}")
@iw.move_to(@a+@c+3,@b+@d-15)

$movie.add(SWFAction.new("


function updateOutput() {
txf = TextField.StyleSheet;
  myStyleSheet = new txf();
  myStyleSheet.parseCSS(mycss);
  #{@instance}.styleSheet = myStyleSheet;
  #{@instance}.htmlText = str;
}


_root.createTextField('#{@instance}',#{@depth},#{@a},#{@b},#{@c},#{@d});
with(#{@instance}){ #{@border}; html = true; #{@embedFonts}; scroll=1; multiline=true; wordWrap=true;}
str = '';
str+='#{@textadd}';


#{@instance}.scrollWheelEnabled = true;


myListener#{@instance} = new Object();
myListener#{@instance}.onScroller = function() {
  MaxValue#{@instance} = #{@instance}.maxscroll;
  MouseOverText#{@instance}();
}; 

#{@instance}.addListener(myListener#{@instance});


#{@instance}.htmlText = str;
updateOutput();


MinValue =1;
Increment =1;
TextField#{@instance} = new Object(_root.#{@instance});
MaxValue#{@instance} = #{@instance}.maxscroll;
Initialize#{@instance}();

function UpdateBar#{@instance}() {
	_parent.#{@instance} = TextField#{@instance}.scroll;
	Value#{@instance} = TextField#{@instance}.scroll;
	DragButton#{@instance}._y = ((Value#{@instance}-MinValue)/(MaxValue#{@instance}-MinValue)*(#{@d}-48));
	Reposition#{@instance}();
};

function MouseOverText#{@instance}() {
	if (TextField#{@instance}._ymouse > 0){
		if (TextField#{@instance}._ymouse < TextField#{@instance}._height) {
		if (TextField#{@instance}._xmouse < TextField#{@instance}._width) {
		if (TextField#{@instance}._xmouse > 0) {
		UpdateBar#{@instance}();
		}
		}
		}
	}
};
  
function Initialise#{@instance}() {
        DownButton#{@instance}._x = #{@a}+#{@c}+2;
	DownButton#{@instance}._y = #{@d} - 37;
	BackgroundV._yscale = (((#{@d} / 16))*100) + 1;
	BackgroundV_gap2._y = #{@d} - 1;
	Value#{@instance} = MinValue;
	Reposition#{@instance}();
};

function Reposition#{@instance}() {

	DragButton#{@instance}._y = ((Value#{@instance}-MinValue)/(MaxValue#{@instance}-MinValue)*(#{@d}-48))+#{@b}+16;
	TextField#{@instance}.scroll = Value#{@instance};
};

function Revalue#{@instance}() {
	Value#{@instance} = (((DragButton#{@instance}._y-#{@b}-16)/(#{@d}-48))*(MaxValue#{@instance}-MinValue)) + MinValue;
	DragButton#{@instance}._x = #{@a}+#{@c}+3;
	Value#{@instance} = int(Value#{@instance}/Increment)*Increment;
	TextField#{@instance}.scroll = Value#{@instance};
	if (dragging == 'false') {
	Reposition#{@instance}();
	}
};
	idmouseText#{@instance} = setInterval(MouseOverText#{@instance}, 300);

"));

 end
end
