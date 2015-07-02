#!/usr/bin/ruby
# starfield.rb -k
# original script on http;//www.redhot.pepper.jp/ming_php
# Ruby version by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0  2006/12/26
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(6)

movie = SWFMovie.new
movie.set_dimension(320,240)
movie.set_background(0x00, 0x00, 0x00 )
movie.set_rate(31)

shp_circle = SWFShape.new
shp_circle.set_right_fill(shp_circle.add_fill(255,255,255))
shp_circle.draw_circle(2)

spr_circle = SWFMovieClip.new
f = spr_circle.add(shp_circle)
spr_circle.next_frame
movie.add_export(spr_circle, "star")
movie.write_exports

strAction = "
sx = 320; sy = 240;
mx = sx / 2;
my = sy / 2;
ob = [];
for(i=1;i<100;i++){
  ob[i] = _root.attachMovie('star','s'+i,i+10);
  ob[i].x = Math.random()*sx - mx;
  ob[i].y = Math.random()*sy - my;
  ob[i].z = Math.random()*2100 + 50;
};

_root.onEnterFrame = function(){
  for(i=1;i<100;i++){
    with(ob[i]){
      z = z - 40;
      if (z < 10){
        x = Math.random()*sx - mx;
        y = Math.random()*sy - my;
        z = 2100 + Math.random()*50;
      };
      ob[i]._xscale = 210 - (z * 0.1); // 210
      ob[i]._yscale = 210 - (z * 0.1); // 210
      ob[i]._x = mx + (x * 1000 / z);
      ob[i]._y = my + (y * 1000 / z);
    };
  };
};
"

movie.add(SWFAction.new(strAction))
movie.save("starfield.swf")
