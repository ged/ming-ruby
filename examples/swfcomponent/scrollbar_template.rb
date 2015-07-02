#!/usr/bin/ruby

# This is an example file for SWFMing_T_Scrollbar.rb mixin module for ming-ruby wrapper.
# Module SWFMing_T_Scrollbar works as a wrapper for TextField class created with ActionScript, adding 
# all the code and bitmaps needed for automatic creation of the scrollbar.
# It is a GNU public licenced script.
# Author Pawel Karwowski pkarwow at fastmail dot fm

# First you have to copy SWFMing_T_Scrollbar.rb file to your ming-ruby default directory.
# Then copy /pictures and all related bitmaps.
# It should be something like:  /usr/lib/ruby/site_ruby/1.8/ming/SWFMing_T_Scrollbar.rb
# And also                      /usr/lib/ruby/site_ruby/1.8/ming/pictures/*
# In case of other directory change variable @PATH in the module.


require 'ming/ming'
require 'ming/SWFMing_T_Scrollbar'

include Ming

# for now everything works for default scale 20.00000000 only...
#set_scale(20.0000000)
use_SWF_version(9)

# variable $movie is used in SWFMing_T_Scrollbar mixin module, so if you want to use some other
# variable (for example $m), you have to write something like $m = $movie = SWFMovie.new 
# Certainly if you prefer $movie name of variable, writing just $movie = SWFMovie.new suits fine...

$m = $movie = SWFMovie.new
$m.set_dimension(600, 400)
$m.set_background(0xdd, 0xff, 0xdd)


# make your CSS...

$m.add(SWFAction.new("_global.mycss='
.text {color: #000000; margin-left: 10px; margin-right: 5px; font-style: normal; font-weight: normal;font-family: courier; font-size: 9px;}
.blue {color: #000FF0; margin-left: 10px; margin-right: 5px; font-style: normal; font-weight: normal; font-family: _sans; font-size: 9px;}
.green {color: #0FF000; margin-left: 10px; margin-right: 5px; font-style: normal; font-weight: bold; font-family: _serif; font-size: 10px;}
.orange {color: #E89403; margin-left: 10px; margin-right: 5px; font-style: normal; font-weight: bold; font-family: _sans; font-size: 8px;}
.red {color: #FF2222; margin-left: 20px; margin-right: 5px; font-style: normal; font-weight: normal;font-family: _sans; font-size: 12px;}
';
"))

# Then:
# SWFMing_T_Scrollbar.new(instance, depth, a, b, c, d, border, emedfonts, textadd)
# where "instance" is a unique name of the TextField instance
# depth is a unique depth of the TextField 
# a is a left position of the TextField (in pixels)
# b is a top position of the TextField (in pixels)
# c is the length of the TextField
# d is the height of the TextField
# border is a texfield flag
# embedFonts is a textfield flag as well
# textadd is CSS formatted text we want to put into TextField
# ScrollBar is resized automatically

SWFMing_T_Scrollbar.new("form1", 21, 
10, 21, 200, 280, 
"border=true", "embedFonts=false",

"<span class=\"red\">1). SWFMing_T_Scrollbar module.</span>&nbsp;
<span class=\"orange\">This is an SWFMing_T_Scrollbar.rb mixin module example for MING. ActionScript code and graphics are borrowed from SWFTools, an GNU Public Licenced, Open Source project, that also reuses some code borrowed from Ming, so we are both equally legal. The original author of Scrollbar code accordingly to README file supported in SWFTools source is named Pipey. Code for this module is anyway significantly different, enabling multiple instances of TextFields with scrolling invoked in a simple way.
</span>&nbsp;
<span class=\"red\"> 2). Using module.</span>&nbsp;
<p class=\"text\">Version 0.39 for Ruby gives the full opportunity for quick and easy creation of scrollbar enabled textfields in Ming swf movies. It works as a wrapper of ActionScript 1.0 TextField class. Rendering is fast and speed of scrolling is good for both device and embedded fonts. The prototype covers size of TextField and CSS formatted text that can be put into TextField. Instances of the module are invoked using simple SWFMing_T_Scrollbar.new () syntax  </p>
<span class=\"red\"> 3). TAB and ENTER.</span>&nbsp;
<p class=\"green\">You can use TAB and ENTER for navigation. It works well on slow computers, even on Pentium 133 you dont have to wait for a scrolling. This scrollbar example works with Flash 7 with mouse enabled. On Flash 6 movies mouse does not works. </p>
<span class=\"red\"> 4). Author.</span>&nbsp;
<p class=\"blue\">Ruby code of SWFMing_T_Scrollbar mixin module for MING by Pawel Karwowski pkarwow at NOSPAM fastmail dot fm. It is an GNU Public Licenced script. </p>
")

SWFMing_T_Scrollbar.new("form2", 22, 
250, 20, 290, 200, 
"border=true", "embedFonts=false",

"<span class=\"red\">1). SWFMing_T_Scrollbar module.</span>&nbsp;
<span class=\"blue\">This is an SWFMing_T_Scrollbar.rb mixin module example for MING. ActionScript code and graphics are borrowed from SWFTools, an GNU Public Licenced, Open Source project, that also reuses some code borrowed from Ming, so we are both equally legal. The original author of Scrollbar code accordingly to README file supported in SWFTools source is named Pipey. Code for this module is anyway significantly different, enabling multiple instances of TextFields with scrolling invoked in a simple way.
</span>&nbsp;
<span class=\"red\"> 2). Using module.</span>&nbsp;
<p class=\"green\">Version 0.39 for Ruby gives the full opportunity for quick and easy creation of scrollbar enabled textfields in Ming swf movies. It works as a wrapper of ActionScript 1.0 TextField class. Rendering is fast and speed of scrolling is good for both device and embedded fonts. The prototype covers size of TextField and CSS formatted text that can be put into TextField. Instances of the module are invoked using simple SWFMing_T_Scrollbar.new () syntax  </p>
<span class=\"red\"> 3). TAB and ENTER.</span>&nbsp;
<p class=\"text\">You can use TAB and ENTER for navigation. It works well on slow computers, even on Pentium 133 you dont have to wait for a scrolling. This scrollbar example works with Flash 7 with mouse enabled. On Flash 6 movies mouse does not works. </p>
<span class=\"red\"> 4). Author.</span>&nbsp;
<p class=\"blue\">Ruby code of SWFMing_T_Scrollbar mixin module for MING by Pawel Karwowski pkarwow at NOSPAM fastmail dot fm. It is an GNU Public Licenced script. </p>
")

SWFMing_T_Scrollbar.new("form3", 23, 
20, 320, 290, 70, 
"border=true", "embedFonts=false",

"<span class=\"red\">1). SWFMing_T_Scrollbar module.</span>&nbsp;
<span class=\"text\">This is an SWFMing_T_Scrollbar.rb mixin module example for MING. ActionScript code and graphics are borrowed from SWFTools, an GNU Public Licenced, Open Source project, that also reuses some code borrowed from Ming, so we are both equally legal. The original author of Scrollbar code accordingly to README file supported in SWFTools source is named Pipey. Code for this module is anyway significantly different, enabling multiple instances of TextFields with scrolling invoked in a simple way.
</span>&nbsp;
<span class=\"red\"> 2). Using module.</span>&nbsp;
<p class=\"blue\">Version 0.39 for Ruby gives the full opportunity for quick and easy creation of scrollbar enabled textfields in Ming swf movies. It works as a wrapper of ActionScript 1.0 TextField class. Rendering is fast and speed of scrolling is good for both device and embedded fonts. The prototype covers size of TextField and CSS formatted text that can be put into TextField. Instances of the module are invoked using simple SWFMing_T_Scrollbar.new () syntax  </p>
<span class=\"red\"> 3). TAB and ENTER.</span>&nbsp;
<p class=\"orange\">You can use TAB and ENTER for navigation. It works well on slow computers, even on Pentium 133 you dont have to wait for a scrolling. This scrollbar example works with Flash 7 with mouse enabled. On Flash 6 movies mouse does not works. </p>
<span class=\"red\"> 4). Author.</span>&nbsp;
<p class=\"green\">Ruby code of SWFMing_T_Scrollbar mixin module for MING by Pawel Karwowski pkarwow at NOSPAM fastmail dot fm. It is an GNU Public Licenced script. </p>
")

# add your own stuff to the timeline...

  @s = SWFShape.new
  @s.set_right_fill(@s.add_fill(0xff, 0, 0))
  @s.move_pen_to(-50,-50)
  @s.draw_line_to(50,-50)
  @s.draw_line_to(50,50)
  @s.draw_line_to(-50,50)
  @s.draw_line_to(-50,-50)

  @i = $m.add(@s)
  @i.move_to(450,300)
  @i.set_name("happy_red_square")

$m.save("scrollbar.swf",9)