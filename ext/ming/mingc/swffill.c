/* swffill.c	- SWFFill class
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

#include <ming.h>
#include "ruby.h"
#include "mingc.h"

VALUE rb_cSWFFill;

void rb_free_SWFFill(p)
	 struct RSWFFill *p;
{
  destroySWFFill(p->this);

  return;
}

static VALUE
rb_SWFFill_skew_x(self, x)
	 VALUE self, x;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_skewX(f->this, NUM2DBL(x));
  
  return self;
}

static VALUE
rb_SWFFill_skew_x_to(self, x)
	 VALUE self, x;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_skewXTo(f->this, NUM2DBL(x));
  
  return self;
}

static VALUE
rb_SWFFill_skew_y(self, y)
	 VALUE self, y;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_skewY(f->this, NUM2DBL(y));
  
  return self;
}

static VALUE
rb_SWFFill_skew_y_to(self, y)
	 VALUE self, y;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_skewYTo(f->this, NUM2DBL(y));
  
  return self;
}

static VALUE
rb_SWFFill_scale_x(self, x)
	 VALUE self, x;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_scaleX(f->this, NUM2DBL(x));
  
  return self;
}

static VALUE
rb_SWFFill_scale_x_to(self, x)
	 VALUE self, x;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_scaleXTo(f->this, NUM2DBL(x));
  
  return self;
}

static VALUE
rb_SWFFill_scale_y(self, y)
	 VALUE self, y;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_scaleY(f->this, NUM2DBL(y));
  
  return self;
}

static VALUE
rb_SWFFill_scale_y_to(self, y)
	 VALUE self, y;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_scaleYTo(f->this, NUM2DBL(y));
  
  return self;
}

static VALUE
rb_SWFFill_scale_x_y(self, r)
     VALUE self, r;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_scaleXY(f->this, NUM2DBL(r), NUM2DBL(r));
  
  return self;
}

static VALUE
rb_SWFFill_scale_x_y_to(self, r)
     VALUE self, r;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_scaleXYTo(f->this, NUM2DBL(r), NUM2DBL(r));
  
  return self;
}

static VALUE
rb_SWFFill_rotate_to(self, d)
	 VALUE self, d;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_rotateTo(f->this, NUM2DBL(d));
  
  return self;
}

static VALUE
rb_SWFFill_rotate(self, d)
	 VALUE self, d;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_rotate(f->this, NUM2DBL(d));
  
  return self;
}

static VALUE
rb_SWFFill_move(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_move(f->this, NUM2DBL(x), NUM2DBL(y));
  
  return self;
}

static VALUE
rb_SWFFill_move_to(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_moveTo(f->this, NUM2DBL(x), NUM2DBL(y));
  
  return self;
}

static VALUE
rb_SWFFill_set_matrix(self, a, b, c, d, x, y)
	 VALUE self, a, b, c, d, x, y;
{
  struct RSWFFill *f;

  Data_Get_Struct(self, struct RSWFFill, f);
  SWFFill_setMatrix(f->this, NUM2DBL(a), NUM2DBL(b),
		    NUM2DBL(c), NUM2DBL(d),
		    NUM2DBL(x), NUM2DBL(y));
  
  return self;
}

void Init_swffill()
{
  rb_cSWFFill = rb_define_class_under(rb_mMing, "SWFFill",
                                      rb_cObject);

  rb_define_const(rb_cSWFFill, "SOLID",
                  INT2FIX(SWFFILL_SOLID));
  rb_define_const(rb_cSWFFill, "GRADIENT",
                  INT2FIX(SWFFILL_GRADIENT));
  rb_define_const(rb_cSWFFill, "LINEAR_GRADIENT",
                  INT2FIX(SWFFILL_LINEAR_GRADIENT));
  rb_define_const(rb_cSWFFill, "RADIAL_GRADIENT",
                  INT2FIX(SWFFILL_RADIAL_GRADIENT));
  rb_define_const(rb_cSWFFill, "FOCAL_GRADIENT",
                  INT2FIX(SWFFILL_FOCAL_GRADIENT));
  rb_define_const(rb_cSWFFill, "BITMAP",
                  INT2FIX(SWFFILL_BITMAP));		  		  
  rb_define_const(rb_cSWFFill, "TILED_BITMAP",
                  INT2FIX(SWFFILL_TILED_BITMAP));
  rb_define_const(rb_cSWFFill, "CLIPPED_BITMAP",
                  INT2FIX(SWFFILL_CLIPPED_BITMAP));
  rb_define_const(rb_cSWFFill, "NONSMOOTHED_TILED_BITMAP",
                  INT2FIX(SWFFILL_NONSMOOTHED_TILED_BITMAP));
  rb_define_const(rb_cSWFFill, "NONSMOOTHED_CLIPPED_BITMAP",
                  INT2FIX(SWFFILL_NONSMOOTHED_CLIPPED_BITMAP));		  

  rb_define_method(rb_cSWFFill, "skew_x",
                   rb_SWFFill_skew_x, 1);
  rb_define_method(rb_cSWFFill, "skew_x_to",
                   rb_SWFFill_skew_x_to, 1);
  rb_define_method(rb_cSWFFill, "skew_y",
                   rb_SWFFill_skew_y, 1);
  rb_define_method(rb_cSWFFill, "skew_y_to",
                   rb_SWFFill_skew_y_to, 1);
  rb_define_method(rb_cSWFFill, "scale_x",
                   rb_SWFFill_scale_x, 1);
  rb_define_method(rb_cSWFFill, "scale_x_to",
                   rb_SWFFill_scale_x_to, 1);
  rb_define_method(rb_cSWFFill, "scale_y",
                   rb_SWFFill_scale_y, 1);
  rb_define_method(rb_cSWFFill, "scale_y_to",
                   rb_SWFFill_scale_y_to, 1);
  rb_define_method(rb_cSWFFill, "scale_x_y",
                   rb_SWFFill_scale_x_y, 1);
  rb_define_method(rb_cSWFFill, "scale_x_y_to",
                   rb_SWFFill_scale_x_y_to, 1);
  rb_define_alias(rb_cSWFFill, "scale", "scale_x_y");
  rb_define_alias(rb_cSWFFill, "scale_to", "scale_x_y_to");
  rb_define_method(rb_cSWFFill, "rotate",
                   rb_SWFFill_rotate, 1);
  rb_define_method(rb_cSWFFill, "rotate_to",
                   rb_SWFFill_rotate_to, 1);
  rb_define_method(rb_cSWFFill, "move",
                   rb_SWFFill_move, 2);
  rb_define_method(rb_cSWFFill, "move_to",
                   rb_SWFFill_move_to, 2);
  rb_define_method(rb_cSWFFill, "set_matrix",
                   rb_SWFFill_set_matrix, 6);

  return;
}
