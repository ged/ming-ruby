#!/usr/bin/ruby
# Author: http://www.redhotpepper.jp
# Ruby code by Pawel Karwowski pkarwow at fastmail dot fm

require 'ming/ming'
include Ming

use_SWF_version(8)
@movie = SWFMovie.new
@movie.set_rate(31)
@movie.set_dimension(450, 180)
@movie.set_background(0xaa,0xaa,0xff)

@movie.add(SWFAction.new("
 
// create textfield
this.createTextField('txtField', this.getNextHighestDepth(), 0, 0, 320, 85);
txtField.html = true;
txtField.htmlText = '<font size=\"70\"><b>ming-ruby</b></font>';
txtField.textColor = 0xff0000;
// set new antialias mode
txtField.antiAliasType = flash.text.TextRenderer.AntiAliasType.ADVANCED;
 
txtField._x=(Stage.width - txtField._width)/2;
txtField._y=(Stage.height - txtField._height)/2;
 
 
// create GradientGlow filter
var gradientF = new flash.filters.GradientGlowFilter();
gradientF.distance = 0;
gradientF.angle = 0;
gradientF.colors = [0x0000FF, 0xFFFF00, 0xeeeebb];
gradientF.alphas = [0.9, 1, 1];
gradientF.ratios = [0, 60, 120];
gradientF.blurX  = 64;
gradientF.blurY  = 64;
gradientF.strength = 1.5;
gradientF.quality = 3;
gradientF.type = 'full';
gradientF.knockout = false;
txtField.filters = [gradientF];
 
bmpData = new flash.display.BitmapData(600, 200);
mc = createEmptyMovieClip('empty', this.getNextHighestDepth());
mc.attachBitmap(bmpData, 0, true, 0xFFFFFFFF);
 
// set perlinNoise data
pos = [
    {x:0, y:0},  
    //{x:0, y:0},
    {x:0, y:0}
];
rand = Math.floor(Math.random()*10); //10000
 
onEnterFrame = function () {
        pos[0].y += 2;
        pos[1].x += 1;
        // create perlinNoise
        bmpData.perlinNoise(50, 50, 2, rand, true, true, 0x0F, false, pos);
};
 
// create textfield2
this.createTextField('txtField2', this.getNextHighestDepth(), 0, 0, 335, 85);
txtField2.html = true;
txtField2.htmlText = '<font size=\"70\"><b>ming-ruby</b></font>';
txtField2.textColor = 0xff0000;
// set new antialias mode
txtField2.antiAliasType = flash.text.TextRenderer.AntiAliasType.ADVANCED;
txtField2._x=(Stage.width - txtField2._width)/2;
txtField2._y=(Stage.height - txtField2._height)/2;
 
// create textfield3
this.createTextField('txtField3', this.getNextHighestDepth(), 0, 0, 150, 30);
txtField3.html = true;
txtField3.htmlText = '<font size=\"20\"><b>redhot.pepper.jp</b></font>';
txtField3.textColor = 0x000088;
// set new antialias mode
txtField3.antiAliasType = flash.text.TextRenderer.AntiAliasType.ADVANCED;
txtField3._x=(Stage.width - txtField3._width)/2;
txtField3._y=(Stage.height - txtField2._height)/2 + txtField2._height-10;
"
))

@movie.save("gradientglow.swf", 9)