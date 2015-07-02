#!/usr/bin/ruby

# blink5.rb -k
# http://blue.ribbon.to/~harpy/ming/blink/show.php?blink5.php
# http://www.kumamushi.org/~k/ming

require 'ming/ming'
include Ming

class SWFSprite < SWFMovieClip; end

set_scale(20.0)

mlen = 144  # Size of movie
slen = mlen * 2.0/3  # Size of sprite
# Number of sprites attached on movie
snx = 10
sny = 4

# Colors
# red, yellow, green, cyan, blue, magenta .. like
red = []; green = []; blue = []
# Type 0
red.push(0xff, 0xff, 0x00, 0x00, 0x00, 0xff)
green.push(0x00, 0xff, 0xff, 0xff, 0x00, 0x00)
blue.push(0x00, 0x00, 0x00, 0xff, 0xff, 0xff)
# Type 1
red.push(0xff, 0xff, 0x80, 0x80, 0x80, 0xff)
green.push(0x80, 0xff, 0xff, 0xff, 0x80, 0x80)
blue.push(0x80, 0x80, 0x80, 0xff, 0xff, 0xff)
# Type 2
red.push(0xff, 0x80, 0x00, 0x80, 0x00, 0x80)
green.push(0x80, 0xff, 0xff, 0x80, 0x80, 0x80)
blue.push(0x00, 0x80, 0x80, 0xff, 0xff, 0xff)
# Type 3
red.push(0xff, 0xff, 0x80, 0x80, 0x80, 0xff)
green.push(0x00, 0x80, 0xff, 0xff, 0x00, 0x80)
blue.push(0x80, 0x80, 0x00, 0x80, 0xff, 0x80)

# Create the sprite
p = SWFSprite.new
n = red.size
(0...n).each do |k|
  # Draw the shape
  s = SWFShape.new
  f = s.add_fill(red[k], green[k], blue[k])
  s.set_right_fill(f)
  s.move_pen_to(-slen/2.0, -slen/2.0)
  s.draw_line(slen, 0)
  s.draw_line(0, slen)
  s.draw_line(-slen, 0)
  s.draw_line(0, -slen)
  i = p.add(s)
  (1..24).each do |j|		# if (0...24), lefts dirty gray background
    i.mult_color(1.0, 1.0, 1.0, 0.75*j/24.0)
    i.rotate_to(-360.0/4/24*j)
    p.next_frame
  end
  (1..24).each do |j|
    i.mult_color(1.0, 1.0, 1.0, 0.75*(24-j)/24.0)
    i.rotate_to(-360.0/4/24*j)
    p.next_frame
  end
  p.remove(i)
end

# Make the movie
m = SWFMovie.new
n = red.size
(0...sny).each do |y|
  (0...snx).each do |x|
    i = m.add(p)
    i.set_name("sq#{y}#{x}")
    i.move_to(mlen/2.0 + slen*x, mlen/2.0 + slen*y)
    m.add(SWFAction.new("sq#{y}#{x}.gotoAndPlay(48*random(#{n})+2*(#{x}+#{y}));"))
  end
end
m.set_background(0xff, 0xff, 0xff)
m.set_dimension(mlen + slen*(snx-1), mlen + slen*(sny-1))


# Save the movie
m.save("blink5.swf")

