/* swfbuttonrecord.c    	- SWFButtonRecord class
 * $Id$
 *
 * Copyright (C) 2007 Pawel Karwowski baribal at forall dot pl
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

VALUE rb_cSWFButtonRecord;

static VALUE
rb_SWFButtonRecord_skew_x(self, x)
	 VALUE self, x;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_skewX(br->this, NUM2DBL(x));

  return self;
}


static VALUE
rb_SWFButtonRecord_skew_y(self, x)
	 VALUE self, x;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_skewY(br->this, NUM2DBL(x));

  return self;
}


static VALUE
rb_SWFButtonRecord_skew_x_to(self, x)
	 VALUE self, x;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_skewXTo(br->this, NUM2DBL(x));

  return self;
}


static VALUE
rb_SWFButtonRecord_skew_y_to(self, x)
	 VALUE self, x;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_skewYTo(br->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFButtonRecord_scale(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_scale(br->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFButtonRecord_scale_to(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  VALUE x, y;
  struct RSWFButtonRecord *br;

  rb_scan_args(argc, argv, "11", &x, &y);

  Data_Get_Struct(self, struct RSWFButtonRecord, br);

  if (NIL_P(y))
    SWFButtonRecord_scaleTo(br->this, NUM2DBL(x), NUM2DBL(x));
  else
    SWFButtonRecord_scaleTo(br->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFButtonRecord_rotate(self, d)
	 VALUE self, d;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_rotate(br->this, NUM2DBL(d));

  return self;
}

static VALUE
rb_SWFButtonRecord_rotate_to(self, d)
	 VALUE self, d;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_rotateTo(br->this, NUM2DBL(d));

  return self;
}


static VALUE
rb_SWFButtonRecord_move(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_move(br->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFButtonRecord_move_to(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_moveTo(br->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFButtonRecord_set_blend_mode(self, mode)
	 VALUE self, mode;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_setBlendMode(br->this, NUM2INT(mode));

  return self;
}

static VALUE
rb_SWFButtonRecord_set_depth(self, depth)
	 VALUE self, depth;
{
  struct RSWFButtonRecord *br;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  SWFButtonRecord_setDepth(br->this, NUM2INT(depth));

  return self;
}


static VALUE
rb_SWFButtonRecord_add_filter(self, filter)
	 VALUE self, filter;
{
  struct RSWFButtonRecord *br;
  struct RSWFFilter *f;

  Data_Get_Struct(self, struct RSWFButtonRecord, br);
  Data_Get_Struct(filter, struct RSWFFilter, f);

  SWFButtonRecord_addFilter(br->this, f->this);
  
  return self;
}


void Init_swfbuttonrecord()
{
  rb_cSWFButtonRecord = rb_define_class_under(rb_mMing, "SWFButtonRecord", 
                                           rb_cObject);
  
  rb_define_method(rb_cSWFButtonRecord, "skew_x",
                   rb_SWFButtonRecord_skew_x, 1);
  rb_define_method(rb_cSWFButtonRecord, "skew_y",
                   rb_SWFButtonRecord_skew_y, 1);
  rb_define_method(rb_cSWFButtonRecord, "skew_x_to",
                   rb_SWFButtonRecord_skew_x_to, 1);		   
  rb_define_method(rb_cSWFButtonRecord, "skew_y_to",
                   rb_SWFButtonRecord_skew_y_to, 1);
  rb_define_method(rb_cSWFButtonRecord, "scale",
                   rb_SWFButtonRecord_scale, 2);
  rb_define_method(rb_cSWFButtonRecord, "scale_to",
                   rb_SWFButtonRecord_scale_to, -1);
  rb_define_method(rb_cSWFButtonRecord, "rotate",
                   rb_SWFButtonRecord_rotate, 1);
  rb_define_method(rb_cSWFButtonRecord, "rotate_to",
                   rb_SWFButtonRecord_rotate_to, 1);		   
  rb_define_method(rb_cSWFButtonRecord, "move",
                   rb_SWFButtonRecord_move, 2);
  rb_define_method(rb_cSWFButtonRecord, "move_to",
                   rb_SWFButtonRecord_move_to, 2);
  rb_define_method(rb_cSWFButtonRecord, "set_blend_mode",
                   rb_SWFButtonRecord_set_blend_mode, 1);
  rb_define_method(rb_cSWFButtonRecord, "set_depth",
                   rb_SWFButtonRecord_set_depth, 1);		   
  rb_define_method(rb_cSWFButtonRecord, "add_filter",
                   rb_SWFButtonRecord_add_filter, 1);					   
  return;
}

