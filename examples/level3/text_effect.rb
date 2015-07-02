#!/usr/bin/ruby
#
# text_effect.rb
# original script by Sham Bhangal in Flash hacks book.
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.12.27
#

require 'ming/ming'
include Ming

set_scale(20.00000000)
use_SWF_version(7)

movie = SWFMovie.new

movie.set_dimension(500,450)
movie.set_background(0xcc,0xcc,0xcc)
movie.set_rate(31)

  f = open("./AScode/Efekt.as", "r")
  ary = f.readlines
       as = SWFAction.new(ary.to_s)
       movie.add(as)
  f.close

t = SWFText.new
t.set_font(SWFFont.new("../common/Verdana.fdb"))
t.add_string(" abcdefghijklmnoprstuwvxyzTWM!.")
i = movie.add(t)

strA = SWFAction.new("
_root.createEmptyMovieClip('myclip');
_root.myclip.createTextField('AStxt',87,100,100,250,200);
_root.myclip.AStxt.multiline = true;
_root.myclip.AStxt.wordWrap = true;
_root.myclip.AStxt.border = true;
_root.myclip.AStxt.embedFonts = true;
_root.myclip.AStxt.type = 'dynamic';
//_root.myclip.AStxt.text = 'mm';
")

holder = SWFMovieClip.new
f1 = holder.add(strA)
holder.next_frame
movie.add_export(holder, 'letter')

sprite = SWFMovieClip.new
f2 = movie.add(sprite)
f2.set_name("myclip")
f2.move_to(20,20)

movie.save("text_effect.swf", 9);
