#!/usr/bin/ruby
#
# fire.rb - Anonymous
# original is http://ming.sourceforge.net anonymous post on ming-users list
# $Log: fire.rb,v $
# Revision 1.4  2008/02/17 11:15:43  baribal
# *** empty log message ***
#
# Revision 1.3  2008/01/27 15:01:31  baribal
# *** empty log message ***
#
# Revision 1.2  2008/01/20 08:38:49  baribal
# *** empty log message ***
#
# Revision 1.1  2008/01/19 17:28:07  baribal
# initial commit
#

require 'ming/ming'
include Ming

set_scale(1.00000000)
use_SWF_version(9)

m = SWFMovie.new
m.set_background(0x0, 0x0, 0x0)
m.set_dimension(500, 450)
m.set_rate(50)

radius=15

g = SWFGradient.new
g.add_entry(0.0,255,255,255,255)
g.add_entry(1.0,255,255,255,0)


fillstyle = SWFFillStyle.new(g, SWFFill::RADIAL_GRADIENT)

fill = fillstyle::fill_from_fillstyle

shapefire = SWFShape.new
shapefire.set_right_fill(fill)

shapefire.move_pen_to(0, 0)
shapefire.draw_circle(radius)


pbsprite= SWFMovieClip.new
itmp=pbsprite.add(shapefire)
itmp.set_blend_mode(SWFBlendMode::HARD_LIGHT)

strAction = "
scale = Number(random(50)) + 30;
//setProperty(_target, _x, _root.x + random(12)-6);
//setProperty(_target, _yscale, scale);
this._x= _root.x + (random(12)-6)/15;
this._yscale=1.7*(Number(random(50)) + 30);
"

pbsprite.add(SWFAction.new(strAction))

itmp.set_matrix(1,0,0,1,1.85,-0.30)
pbsprite.next_frame()

itmp.set_matrix(1.028,0,0,1.028,1.85,-9.15)
itmp.mult_color(0.7,0.7,0.7,1)
itmp.add_color(78,78,0,0)
pbsprite.next_frame()

itmp.set_matrix(1.052,0,0,1.052,1.85,-16.95)
itmp.mult_color(0.4,0.4,0.4,1)
itmp.add_color(146,146,0,0)
pbsprite.next_frame()

itmp.set_matrix(1.074,0,0,1.074,1.85,-23.70)
itmp.mult_color(0.2,0.2,0.2,1)
itmp.add_color(205,205,0,0)
pbsprite.next_frame()

itmp.set_matrix(1.091,0,0,1.091,1.85,-29.40)
itmp.mult_color(0,0,0,1)
itmp.add_color(255,255,0,0)
pbsprite.next_frame()

itmp.set_matrix(1.109,0,0,1.109,1.85,-34.95)
itmp.mult_color(0,0,0,1)
itmp.add_color(251,235,0,0)
pbsprite.next_frame()

itmp.set_matrix(1.126,0,0,1.126,1.85,-40.55)
itmp.mult_color(0,0,0,1)
itmp.add_color(247,204,0,0)
pbsprite.next_frame()

itmp.set_matrix(1.144,0,0,1.144,1.85,-46.10)
itmp.mult_color(0,0,0,1)
itmp.add_color(243,179,0,0)
pbsprite.next_frame()

itmp.set_matrix(1.162,0,0,1.162,1.85,-51.75)
itmp.mult_color(0,0,0,1)
itmp.add_color(239,153,0,0)
pbsprite.next_frame()

itmp.set_matrix(1.179,0,0,1.179,1.80,-57.25)
itmp.mult_color(0,0,0,1)
itmp.add_color(236,128,1,0)
pbsprite.next_frame()

itmp.set_matrix(1.197,0,0,1.197,1.80,-62.90)
itmp.mult_color(0,0,0,1)
itmp.add_color(232,103,1,0)
pbsprite.next_frame()

itmp.set_matrix(1.214,0,0,1.214,1.80,-68.50)
itmp.mult_color(0,0,0,1)
itmp.add_color(228,77,1,0)
pbsprite.next_frame()

itmp.set_matrix(1.232,0,0,1.232,1.80,-74.10)
itmp.mult_color(0,0,0,1)
itmp.add_color(224,52,1,0)
pbsprite.next_frame()

itmp.set_matrix(1.249,0,0,1.249,1.80,-79.65)
itmp.mult_color(0,0,0,1)
itmp.add_color(220,26,1,0)
pbsprite.next_frame()

itmp.set_matrix(1.267,0,0,1.267,1.80,-85.25)
itmp.mult_color(0,0,0,1)
itmp.add_color(216,1,1,0)
pbsprite.next_frame()

itmp.set_matrix(1.393,0,0,1.393,1.85,-90.85)
itmp.mult_color(0,0,0,1)
itmp.add_color(199,6,6,0)
pbsprite.next_frame()

itmp.set_matrix(1.519,0,0,1.519,1.80,-96.45)
itmp.mult_color(0,0,0,1)
itmp.add_color(183,11,11,0)
pbsprite.next_frame()

itmp.set_matrix(1.645,0,0,1.645,1.85,-102.00)
itmp.mult_color(0,0,0,1)
itmp.add_color(166,16,16,0)
pbsprite.next_frame()

itmp.set_matrix(1.771,0,0,1.771,1.80,-107.60)
itmp.mult_color(0,0,0,1)
itmp.add_color(150,21,21,0)
pbsprite.next_frame()

itmp.set_matrix(1.897,0,0,1.897,1.90,-113.20)
itmp.mult_color(0,0,0,1)
itmp.add_color(134,26,26,0)
pbsprite.next_frame()

itmp.set_matrix(2.023,0,0,2.023,1.85,-118.80)
itmp.mult_color(0,0,0,1)
itmp.add_color(117,31,31,0)
pbsprite.next_frame()

itmp.set_matrix(2.149,0,0,2.149,1.90,-124.35)
itmp.mult_color(0,0,0,1)
itmp.add_color(101,36,36,0)
pbsprite.next_frame()

itmp.set_matrix(2.275,0,0,2.275,1.90,-129.95)
itmp.mult_color(0,0,0,1)
itmp.add_color(84,41,41,0)
pbsprite.next_frame()

itmp.set_matrix(2.401,0,0,2.401,1.90,-135.55)
itmp.mult_color(0,0,0,1)
itmp.add_color(68,46,46,0)
pbsprite.next_frame()

itmp.set_matrix(2.527,0,0,2.527,1.85,-141.15)
itmp.mult_color(0,0,0,1)
itmp.add_color(51,51,51,0)
pbsprite.next_frame()

itmp.set_matrix(2.256,0,0,2.256,1.80,-141.15)
itmp.mult_color(0.2,0.2,0.2,0.8)
itmp.add_color(-26,-26,-26,0)
pbsprite.next_frame()

itmp.set_matrix(1.985,0,0,1.985,1.80,-141.15)
itmp.mult_color(0.5,0.5,0.5,0.5)
itmp.add_color(-102,-102,-102,0)
pbsprite.next_frame()

itmp.set_matrix(1.713,0,0,1.713,1.80,-141.15)
itmp.mult_color(0.8,0.8,0.8,0.2)
itmp.add_color(-179,-179,-179,0)
pbsprite.next_frame()

itmp.set_matrix(1.442,0,0,1.442,1.85,-141.15)
itmp.mult_color(1,1,1,0)
itmp.add_color(-256,-256,-256,0)
pbsprite.next_frame()

i= m.add(pbsprite)
i.move_to(250,250)
i.set_name("fire")

# mx actionscript
strAction = "		
i = 1;
max = 60;
x = _root.fire._x;	
"

m.add(SWFAction.new(strAction))

m.next_frame()

strAction = "		
if ( i <= max) {
	duplicateMovieClip('fire', 'fire' & i, i);
	i = i +1;
}"
m.add(SWFAction.new(strAction))
m.next_frame()

strAction = "
if ( i <=max ) {
	duplicateMovieClip('fire', 'fire' & i, i);
	i = i +1; }
gotoAndPlay(2);
"

m.add(SWFAction.new(strAction))
m.next_frame()

m.save("fire.swf")
