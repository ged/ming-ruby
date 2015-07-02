/* mingc.c - the initial hook for C wrappers
 * $Id$
 *
 * Copyright (C) 2004 IKEGAMI Daisuke <ikegami at madscientist dot jp>
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

#include <stdio.h>
#include <stdarg.h>
#include <ming.h>
#include "ruby.h"
#include "mingc.h"

VALUE rb_mMing;
VALUE rb_eMingError;

static VALUE
rb_Ming_set_cubic_threshold(self, num)
     VALUE self, num;
{
  Ming_setCubicThreshold(NUM2INT(num));
  return self;
}

static VALUE
rb_Ming_set_scale(self, scale)
     VALUE self, scale;
{
  Ming_setScale(NUM2DBL(scale));
  return self;
}

static VALUE
rb_Ming_get_scale(self)
     VALUE self;
{
  return rb_float_new(Ming_getScale());
}

static VALUE
rb_Ming_use_SWF_version(self, version)
     VALUE self, version;
{
  Ming_useSWFVersion(NUM2INT(version));
  return self;
}

void rb_Ming_raise(const char *msg, ...)
{
  va_list args;

  va_start(args, msg);
  rb_raise(rb_eMingError, msg, args);
  va_end(args);
}

void hook_init_func()
{
  Init_swfaction();
  Init_swfbinarydata();
  Init_swfbitmap();
  Init_swfblendmode();
  Init_swfblur();
  Init_swfbrowserfont();
  Init_swfbutton();
  Init_swfbuttonrecord();
  Init_swfcharacter();
  Init_swfcolor();
  Init_swfcxform();
  Init_swfdisplayitem();
  Init_swffill();
  Init_swffillstyle();
  Init_swffilter();  
  Init_swffiltermatrix();    
  Init_swffont();
  Init_swffontcharacter();
  Init_swfgradient();
  Init_swfinitaction();  
  Init_swflinestyle();
  Init_swfmatrix();
  Init_swfmorph();
  Init_swfmovie();
  Init_swfmovieclip();
  Init_swfposition();
  Init_swfshadow();
  Init_swfshape();
  Init_swfsound();
  Init_swfsoundinstance();
  Init_swfsoundstream();
  Init_swftext();
  Init_swftextfield();
  Init_swfprebuiltclip();
  Init_swfvideostream();
  
  return;
}

void Init_mingc()
{
  Ming_init();

  rb_mMing = rb_define_module("Ming");

  /* == error/warning == */
  rb_eMingError = rb_define_class("MingError", rb_eException);
  Ming_setErrorFunction(rb_Ming_raise);
  /* comment:
   * What is the warning function for Ruby?
   * -- print message to stderr? 
   * Ming_setWarnFunction(rb_Ming_warn); 
   */

  /* == Constants == */
  rb_define_const(rb_mMing, "MING_VERSION", rb_str_new2(MING_VERSION_TEXT));

  /* == Module functions == */
  rb_define_module_function(rb_mMing, "set_cubic_threshold",
                            rb_Ming_set_cubic_threshold, 1);
  rb_define_module_function(rb_mMing, "set_scale",
                            rb_Ming_set_scale, 1);
  rb_define_module_function(rb_mMing, "get_scale",
                            rb_Ming_get_scale, 0);
  rb_define_module_function(rb_mMing, "use_SWF_version",
                            rb_Ming_use_SWF_version, 1);

  hook_init_func();

  return;
}

