/* swfblendmode.c 	- SWFBlendMode class
 * $Id$
 *
 * Copyright (C) 2008 Karwowski Pawel
 * All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 * 
 */

#include <ming.h>
#include "ruby.h"
#include "mingc.h"

VALUE rb_cSWFBlendMode;


void Init_swfblendmode()
{
  rb_cSWFBlendMode = rb_define_class_under(rb_mMing, "SWFBlendMode",
					     rb_cObject);


  rb_define_const(rb_cSWFBlendMode, "NULL",
                  INT2FIX(SWFBLEND_MODE_NULL));
  rb_define_const(rb_cSWFBlendMode, "NORMAL",
                  INT2FIX(SWFBLEND_MODE_NORMAL));
  rb_define_const(rb_cSWFBlendMode, "LAYER",
                  INT2FIX(SWFBLEND_MODE_LAYER));		  
  rb_define_const(rb_cSWFBlendMode, "MULT",
                  INT2FIX(SWFBLEND_MODE_MULT));
  rb_define_const(rb_cSWFBlendMode, "SCREEN",
                  INT2FIX(SWFBLEND_MODE_SCREEN));
  rb_define_const(rb_cSWFBlendMode, "LIGHTEN",
                  INT2FIX(SWFBLEND_MODE_LIGHTEN));		  
  rb_define_const(rb_cSWFBlendMode, "DARKEN",
                  INT2FIX(SWFBLEND_MODE_DARKEN));
  rb_define_const(rb_cSWFBlendMode, "DIFF",
                  INT2FIX(SWFBLEND_MODE_DIFF));		  
  rb_define_const(rb_cSWFBlendMode, "ADD",
                  INT2FIX(SWFBLEND_MODE_ADD));
  rb_define_const(rb_cSWFBlendMode, "SUB",
                  INT2FIX(SWFBLEND_MODE_SUB));
  rb_define_const(rb_cSWFBlendMode, "INV",
                  INT2FIX(SWFBLEND_MODE_INV));		  
  rb_define_const(rb_cSWFBlendMode, "ALPHA",
                  INT2FIX(SWFBLEND_MODE_ALPHA));
  rb_define_const(rb_cSWFBlendMode, "ERASE",
                  INT2FIX(SWFBLEND_MODE_ERASE));		  
  rb_define_const(rb_cSWFBlendMode, "OVER_LAY",
                  INT2FIX(SWFBLEND_MODE_OVERLAY));
  rb_define_const(rb_cSWFBlendMode, "HARD_LIGHT",
                  INT2FIX(SWFBLEND_MODE_HARDLIGHT));		  


  return;
}
