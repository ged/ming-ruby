#!/usr/bin/env ruby
#
# sparks.rb -- IKEGAMI Daisuke
#
# $Log: sparks.rb,v $
# Revision 1.3  2008/02/17 11:15:43  baribal
# *** empty log message ***
#
# Revision 1.1  2006/12/17 18:50:00  mcdonaec
# New examples added.
#

require 'ming/ming'
include Ming

use_SWF_version(5)
m = SWFMovie.new
m.set_dimension(320, 240)
m.set_background(0, 0, 0)

m.add(SWFAction.new("_quality = 'LOW'; frames._visible = false; sparks = [];"))
g = SWFGradient.new
g.add_entry(0, 0xff, 0xff, 0xff, 0xff)
g.add_entry(0.1, 0xff, 0xff, 0xff, 0xff)
g.add_entry(0.5, 0xff, 0xff, 0xff, 0x5f)
g.add_entry(1.0, 0xff, 0xff, 0xff, 0)

s = SWFShape.new
f = s.add_fill(g, SWFFill::RADIAL_GRADIENT)
f.scale_to(0.7)
s.set_right_fill(f)
s.move_pen_to(-30, -30)
s.draw_line(60, 0)
s.draw_line(0, 60)
s.draw_line(-60, 0)
s.draw_line(0, -60)

p = SWFMovieClip.new
p.add(s)
p.next_frame

q = SWFMovieClip.new
q.add(SWFAction.new('gotoAndPlay(random(7)+1); stop();'))
i = q.add(p)

i.mult_color(1.0, 1.0, 1.0)
q.next_frame
i.mult_color(1.0, 0.5, 0.5)
q.next_frame
i.mult_color(1.0, 0.75, 0.5)
q.next_frame
i.mult_color(1.0, 1.0, 0.5)
q.next_frame
i.mult_color(0.5, 1.0, 0.5)
q.next_frame
i.mult_color(0.5, 0.5, 1.0)
q.next_frame
i.mult_color(1.0, 0.5, 1.0)
q.next_frame

p = SWFMovieClip.new
i = p.add(q)
i.set_name('frames')
action = "
dx = _root.dx/3 + random(10)-5;
dy = _root.dy/3;
x = _root._xmouse;
y = _root._ymouse;
alpha = 100;
"
p.add(SWFAction.new(action))
p.next_frame

action = "
this._x = x;
this._y = y;
this._alpha = alpha;
x += dx;
y += dy;
dy += 3;
alpha -= 8;
"
p.add(SWFAction.new(action))
p.next_frame

p.add(SWFAction.new('prevFrame(); play();'))
p.next_frame

i = m.add(p)
i.set_name('frames')
m.next_frame

action = "
dx = _xmouse - lastx;
dy = _ymouse - lasty;

lastx = _xmouse;
lasty = _ymouse;

if(++num == 11)
  num = 1;

if(sparks[num])
  removeMovieClip(sparks[num]);

duplicateMovieClip('frames', 'char'+num, num);
sparks[num] = this['char'+num];
"
m.add(SWFAction.new(action))

m.next_frame
m.add(SWFAction.new('prevFrame(); play();'))

m.save('sparks.swf')
