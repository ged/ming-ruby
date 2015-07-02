#!/usr/bin/ruby
#http://www.libming.net/moin.cgi/HowToUseMasks
# Ruby code by Pawel

require 'ming/ming'
include Ming

use_SWF_version(7)

set_scale(20.00000)
@movie = SWFMovie.new
@movie.set_dimension(100, 100)
@movie.set_rate(31)
@movie.set_background(0xcc, 0xcc, 0xcc)


# draw a line

@spline = SWFMovieClip.new
@shline = SWFShape.new
  @shline.set_line(5,0,0,255,255) #thick,r,g,b,[a]
  @shline.move_pen_to(0,0)
  @shline.draw_line_to(100,100)
  @spline.add(@shline)
  @spline.next_frame()

@itline = @movie.add(@spline)

# draw rect
  @sprect = SWFMovieClip.new
  @shrect = SWFShape.new
  @shrect.set_line(1,0,128,0,255) # thick,r,g,b,[a]
  @shrect.move_pen_to(29,29)
  @shrect.draw_line_to(71,29)
  @shrect.draw_line_to(71,71)
  @shrect.draw_line_to(29,71)
  @shrect.draw_line_to(29,29)

 @sprect.add(@shrect)
 @sprect.next_frame()

 @itrect = @movie.add(@sprect)


# build mask for line
@spmask = SWFMovieClip.new
  @shmask = SWFShape.new
  @flmask = SWFFillStyle.new(0x00, 0x00, 0x00, 0x00)
  @shmask.set_right_fill_style(@flmask)
  @shmask.move_pen_to(30,30)
  @shmask.draw_line_to(70,30)
  @shmask.draw_line_to(70,70)
  @shmask.draw_line_to(30,70)
  @shmask.draw_line_to(30,30)
  @spmask.add(@shmask)
  @spmask.next_frame()

  @itmask = @movie.add(@spmask)
# set mask
  @itline.set_depth(3)
  @itrect.set_depth(5)
  @itmask.set_depth(1)

# set different mask levels here 2 or 6 - you will see the difference !!!

  @itmask.set_mask_level(4)
# save
@movie.save("setmask.swf")
 
