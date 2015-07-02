#!/usr/bin/ruby
# spot -k
# http://www.kumamushi.org/~k/ming

require 'ming/ming'
include Ming
include Math

def draw_square(size)
  s = SWFShape.new
  s.set_line(1, 0x33, 0xcc, 0xcc)
  s.move_pen_to(-size/2.0, -size/2.0)
  s.draw_line(size,  0)
  s.draw_line(0,  size)
  s.draw_line(-size, 0)
  s.draw_line(0, -size)
  return s
end

def draw_circle(size)
  s = SWFShape.new
  f = s.add_fill(0x66, 0x99, 0xff, 0x80)
  s.set_right_fill(f)
  r = size/2.0
  a = r * tan(PI/8)
  b = r * sin(PI/4)	# == sqrt(2)/2
  s.move_pen_to(r, 0)
  s.draw_curve_to( r, -a,  b, -b)
  s.draw_curve_to( a, -r,  0, -r)
  s.draw_curve_to(-a, -r, -b, -b)
  s.draw_curve_to(-r, -a, -r,  0)
  s.draw_curve_to(-r,  a, -b,  b)
  s.draw_curve_to(-a,  r,  0,  r)
  s.draw_curve_to( a,  r,  b,  b)
  s.draw_curve_to( r,  a,  r,  0)
  return s
end

def draw_light(size)
  s = SWFShape.new
  g = SWFGradient.new
  g.add_entry(0.0, 0xcc, 0xcc, 0xcc, 0xff)
  g.add_entry(0.7, 0x33, 0x99, 0xff, 0x99)
  g.add_entry(1.0, 0x00, 0x00, 0xff, 0x00)
  f = s.add_fill(g, SWFFill::RADIAL_GRADIENT)
#  f.scale_to(0.05)
  s.set_right_fill(f)
  s.move_pen_to(-size/2.0, -size/2.0)
  s.draw_line(size,  0)
  s.draw_line(0,  size)
  s.draw_line(-size, 0)
  s.draw_line(0, -size)
  return s
end

def main(width, height)
  m = SWFMovie.new
  m.set_dimension(width, height)
  m.set_background(0x33, 0x66, 0x66)
  m.set_rate(8)

  20.step(width - 20, 20) do |x|
    20.step(height - 20, 20) do |y|
      s = draw_square(10)
      i = m.add(s)
      i.move_to(x, y)
    end
  end

  s = draw_circle(100)
  p = SWFMovieClip.new
  p.add(s)
  p.next_frame
  a = m.add(p)
  a.set_name("a")

  s = draw_light(100)
  p = SWFMovieClip.new
  p.add(s)
  p.next_frame
  b = m.add(p)
  b.set_name("b")

  m.add(SWFAction.new("
    w = #{width};
    h = #{height};
    now = new Date();	// in milliseconds
    x = w - w * ( 1 + Math.sin( now / 30000 * Math.PI ) ) / 2;
    y = h - h * ( 1 + Math.sin( now / 20000 * Math.PI ) ) / 2;
    a._x = x;
    a._y = y;
    b._x = y;
    b._y = x;
  "))
  m.next_frame
  m.add(SWFAction.new("
    prevFrame();
    play();
  "))
  m.next_frame

  m.save("spot.swf")
end

main(600, 600)



=begin

# obsolete

def calc_xy(width, height)	# from xscreensaver's spotlight
  margin = 10
  w = width - margin
  h = height - margin
  t = Time.now
  n = t.tv_sec * 1000 + t.tv_usec/1000.0
  x = (w - (1 + sin(n / 30.0 * PI)) / 2.0 * w).to_i + margin / 2
  y = (h - (1 + sin(n / 24.0 * PI)) / 2.0 * h).to_i + margin / 2
  p [n, x, y] if $DEBUG
  return x, y
end


  s = draw_circle(100)
  a = m.add(s)
  s = draw_light(200)
  b = m.add(s)

  60.times do		# flash plugin crash > around 70, why???
    x, y = calc_xy(width, height)
    a.move_to(x, y)
    b.move_to(y, x)
    m.next_frame
  end

=end
