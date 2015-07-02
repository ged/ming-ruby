
 MovieClip.prototype.dashTo = function(startx, starty, endx, endy, len, gap) 
 {
 
     // ==============
 
     // mc.dashTo() - by Ric Ewing (ric@fo...) - version 1.2  - 5.3.2002
 
     //
 
     // startx, starty = beginning of dashed line
 
     // endx, endy = end of dashed line
 
     // len = length of dash
 
     // gap = length of gap between dashes
 
     // ==============
 
     //
 
     // if too few arguments, bail
 
     if (arguments.length < 6) {
 
         return false;
 
     }
 
     // init vars
 
     var seglength, deltax, deltay, segs, cx, cy;
 
     // calculate the legnth of a segment
 
     seglength = len + gap;
 
     // calculate the length of the dashed line
 
     deltax = endx - startx;
 
     deltay = endy - starty;
 
     delta = Math.sqrt((deltax * deltax) + (deltay * deltay));
 
     // calculate the number of segments needed
 
     segs = Math.floor(Math.abs(delta / seglength));
 
     // get the angle of the line in radians
 
     radians = Math.atan2(deltay,deltax);
 
     // start the line here
 
     cx = startx;
 
     cy = starty;
 
     // add these to cx, cy to get next seg start
 
     deltax = Math.cos(radians)*seglength;
 
     deltay = Math.sin(radians)*seglength;
 
     // loop through each seg
 
     for (var n = 0; n < segs; n++) {
 
         this.moveTo(cx,cy);
 
         this.lineTo(cx+Math.cos(radians)*len,cy+Math.sin(radians)*len);
 
         cx += deltax;
 
         cy += deltay;
 
     }
 
     // handle last segment as it is likely to be partial
 
     this.moveTo(cx,cy);
 
     delta = Math.sqrt((endx-cx)*(endx-cx)+(endy-cy)*(endy-cy));
 
     if(delta>len){
 
         // segment ends in the gap, so draw a full dash
 
         this.lineTo(cx+Math.cos(radians)*len,cy+Math.sin(radians)*len);
 
     } else if(delta>0) {
 
         // segment is shorter than dash so only draw what is needed
 
        
this.lineTo(cx+Math.cos(radians)*delta,cy+Math.sin(radians)*delta);
 
     }
 
     // move the pen to the end position
 
     this.moveTo(endx,endy);
 
 };
 
 this.createEmptyMovieClip('dashedline', this.getNextHighestDepth());
 
 with (dashedline)
 
 {
 
         lineStyle(2,0x000000, 100);
 
         dashTo(0,50,50,50,2.5,2.5);
 
 };
 
 
 _root.onEnterFrame = function()
 
 {
 
         _root.clear();
 
         _root.lineStyle(2,0x000000, 100);
 
         _root.dashTo(0,50,_root._xmouse,_root._ymouse,2.5,2.5);
 
 };
