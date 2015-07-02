/* swfdisplayitem.c	- SWFDisplayItem class
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

VALUE rb_cSWFDisplayItem;

static VALUE
rb_SWFDisplayItem_move(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_move(i->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFDisplayItem_move_to(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_moveTo(i->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFDisplayItem_rotate(self, d)
	 VALUE self, d;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_rotate(i->this, NUM2DBL(d));

  return self;
}

static VALUE
rb_SWFDisplayItem_rotate_to(self, d)
	 VALUE self, d;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_rotateTo(i->this, NUM2DBL(d));

  return self;
}

static VALUE
rb_SWFDisplayItem_add_action(self, action, f)
	 VALUE self, action, f;
{
  struct RSWFDisplayItem *di;
  struct RSWFAction *a;

  Data_Get_Struct(self, struct RSWFDisplayItem, di);
  Data_Get_Struct(action, struct RSWFAction, a);

  add_references(di->table, action);
  SWFDisplayItem_addAction(di->this, a->this, NUM2INT(f));
  
  return self;
}



static VALUE
rb_SWFDisplayItem_scale(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_scale(i->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFDisplayItem_scale_to(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  VALUE x, y;
  struct RSWFDisplayItem *i;

  rb_scan_args(argc, argv, "11", &x, &y);

  Data_Get_Struct(self, struct RSWFDisplayItem, i);

  if (NIL_P(y))
    SWFDisplayItem_scaleTo(i->this, NUM2DBL(x), NUM2DBL(x));
  else
    SWFDisplayItem_scaleTo(i->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFDisplayItem_skew_x(self, x)
	 VALUE self, x;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_skewX(i->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFDisplayItem_skew_x_to(self, x)
	 VALUE self, x;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_skewXTo(i->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFDisplayItem_skew_y(self, y)
	 VALUE self, y;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_skewY(i->this, NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFDisplayItem_skew_y_to(self, y)
	 VALUE self, y;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_skewYTo(i->this, NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFDisplayItem_get_position(self)
	 VALUE self;
{
  struct RSWFDisplayItem *i;
  double * x = ALLOC(double), * y = ALLOC(double);

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_getPosition(i->this, x, y);

  return rb_ary_new3(2, rb_float_new(*x), rb_float_new(*y));
}

static VALUE
rb_SWFDisplayItem_get_rotation(self)
	 VALUE self;
{
  struct RSWFDisplayItem *i;
  double * r = ALLOC(double);

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_getRotation(i->this, r);

  return rb_float_new(*r);
}

static VALUE
rb_SWFDisplayItem_get_scale(self)
	 VALUE self;
{
  struct RSWFDisplayItem *i;
  double * x = ALLOC(double), * y = ALLOC(double);

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_getScale(i->this, x, y);

  return rb_ary_new3(2, rb_float_new(*x), rb_float_new(*y));
}

static VALUE
rb_SWFDisplayItem_get_skew(self)
	 VALUE self;
{
  struct RSWFDisplayItem *i;
  double * x = ALLOC(double), * y = ALLOC(double);

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_getSkew(i->this, x, y);

  return rb_ary_new3(2, rb_float_new(*x), rb_float_new(*y));
}

static VALUE
rb_SWFDisplayItem_set_matrix(self, a, b, c, d, x, y)
	 VALUE self, a, b, c, d, x, y;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);

  SWFDisplayItem_setMatrix(i->this, NUM2DBL(a), NUM2DBL(b),
			   NUM2DBL(c), NUM2DBL(d),
			   NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFDisplayItem_get_matrix(self)
	 VALUE self;
{
  struct RSWFDisplayItem *di;
  struct RSWFMatrix *m = ALLOC(struct RSWFMatrix);
  VALUE obj;
  
  Data_Get_Struct(self, struct RSWFDisplayItem, di);
  m->this = SWFDisplayItem_getMatrix(di->this);
  m->table = ALLOC(struct References);
  init_references(m->table);
	
  obj = Data_Wrap_Struct(rb_cSWFMatrix, NULL,
			 -1, m);
			 
  add_references(di->table, obj);

  return obj;
}

static VALUE
rb_SWFDisplayItem_get_depth(self)
	 VALUE self;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);

  return INT2NUM(SWFDisplayItem_getDepth(i->this));
}

static VALUE
rb_SWFDisplayItem_set_depth(self, d)
	 VALUE self, d;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_setDepth(i->this, NUM2INT(d));

  return self;
}

static VALUE
rb_SWFDisplayItem_remove(self)
	 VALUE self;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_remove(i->this);

  return self;
}


static VALUE
rb_SWFDisplayItem_flush(self)
	 VALUE self;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_flush(i->this);

  return self;
}


static VALUE
rb_SWFDisplayItem_end_mask(self)
	 VALUE self;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_endMask(i->this);

  return self;
}


static VALUE
rb_SWFDisplayItem_set_name(self, n)
	 VALUE self, n;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_setName(i->this, StringValuePtr(n));

  return self;
}

static VALUE
rb_SWFDisplayItem_set_mask_level(self, mask)
	 VALUE self, mask;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_setMaskLevel(i->this, NUM2INT(mask));

  return self;
}

static VALUE
rb_SWFDisplayItem_set_ratio(self, r)
	 VALUE self, r;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_setRatio(i->this, NUM2DBL(r));

  return self;
}

static VALUE
rb_SWFDisplayItem_set_cxform(self, form)
     VALUE self, form;
{
  struct RSWFDisplayItem *di;
  struct RSWFCXform *f;

  Data_Get_Struct(self, struct RSWFDisplayItem, di);
  Data_Get_Struct(form, struct RSWFCXform, f);

//  add_references(di->table, form);
  SWFDisplayItem_setCXform(di->this, f->this);

  return self;
}

static VALUE
rb_SWFDisplayItem_set_color_add(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  struct RSWFDisplayItem *i;
  VALUE r, g, b, a;
  int alpha;

  rb_scan_args(argc, argv, "31", &r, &g, &b, &a);
  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  if NIL_P(a)
    alpha = 0;
  else
    alpha = NUM2INT(a);

  SWFDisplayItem_setColorAdd(i->this, NUM2INT(r), NUM2INT(g), NUM2INT(b),
                             alpha);
  return self;
}

static VALUE
rb_SWFDisplayItem_set_color_mult(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  struct RSWFDisplayItem *i;
  VALUE r, g, b, a;
  float alpha;

  rb_scan_args(argc, argv, "31", &r, &g, &b, &a);
  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  if NIL_P(a)
    alpha = 1.0;
  else
    alpha = NUM2DBL(a);

  SWFDisplayItem_setColorMult(i->this, NUM2DBL(r), NUM2DBL(g), NUM2DBL(b), alpha);
  return self;
}

static VALUE
rb_SWFDisplayItem_cache_as_bitmap(self, flag)
	 VALUE self, flag;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_cacheAsBitmap(i->this, NUM2INT(flag));

  return self;
}


static VALUE
rb_SWFDisplayItem_set_blend_mode(self, mode)
	 VALUE self, mode;
{
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFDisplayItem, i);
  SWFDisplayItem_setBlendMode(i->this, NUM2INT(mode));

  return self;
}

static VALUE
rb_SWFDisplayItem_add_filter(self, filter)
	 VALUE self, filter;
{
  struct RSWFDisplayItem *di;
  struct RSWFFilter *f;

  Data_Get_Struct(self, struct RSWFDisplayItem, di);
  Data_Get_Struct(filter, struct RSWFFilter, f);

  add_references(di->table, filter);
  SWFDisplayItem_addFilter(di->this, f->this);
  
  return self;
}

static VALUE
rb_SWFDisplayItem_get_character(self)
     VALUE self;
{
  struct RSWFDisplayItem *di;
  struct RSWFCharacter *ch = ALLOC(struct RSWFCharacter);
  VALUE obj;

  Data_Get_Struct(self, struct RSWFDisplayItem, di);

  ch->this = SWFDisplayItem_getCharacter(di->this);
  ch->table = ALLOC(struct References);
  init_references(ch->table);

  obj = Data_Wrap_Struct(rb_cSWFCharacter, NULL, 
			    -1, ch);
  add_references(di->table, obj);
  return obj;
}

void Init_swfdisplayitem()
{
  rb_cSWFDisplayItem = rb_define_class_under(rb_mMing, "SWFDisplayItem",
					     rb_cObject);

  rb_define_method(rb_cSWFDisplayItem, "move",
                   rb_SWFDisplayItem_move, 2);
  rb_define_method(rb_cSWFDisplayItem, "move_to",
                   rb_SWFDisplayItem_move_to, 2);
  rb_define_method(rb_cSWFDisplayItem, "rotate",
                   rb_SWFDisplayItem_rotate, 1);
  rb_define_method(rb_cSWFDisplayItem, "rotate_to",
                   rb_SWFDisplayItem_rotate_to, 1);
  rb_define_method(rb_cSWFDisplayItem, "add_action",
                   rb_SWFDisplayItem_add_action, 2);		   
  rb_define_method(rb_cSWFDisplayItem, "scale",
                   rb_SWFDisplayItem_scale, 2);
  rb_define_method(rb_cSWFDisplayItem, "scale_to",
                   rb_SWFDisplayItem_scale_to, -1);
  rb_define_method(rb_cSWFDisplayItem, "skew_x",
                   rb_SWFDisplayItem_skew_x, 1);
  rb_define_method(rb_cSWFDisplayItem, "skew_x_to",
                   rb_SWFDisplayItem_skew_x_to, 1);
  rb_define_method(rb_cSWFDisplayItem, "skew_y",
                   rb_SWFDisplayItem_skew_y, 1);
  rb_define_method(rb_cSWFDisplayItem, "skew_y_to",
                   rb_SWFDisplayItem_skew_y_to, 1);
  rb_define_method(rb_cSWFDisplayItem, "get_position",
                   rb_SWFDisplayItem_get_position, 0);
  rb_define_method(rb_cSWFDisplayItem, "get_rotation",
                   rb_SWFDisplayItem_get_rotation, 0);
  rb_define_method(rb_cSWFDisplayItem, "get_scale",
                   rb_SWFDisplayItem_get_scale, 0);
  rb_define_method(rb_cSWFDisplayItem, "get_skew",
                   rb_SWFDisplayItem_get_skew, 0);
  rb_define_method(rb_cSWFDisplayItem, "set_matrix",
                   rb_SWFDisplayItem_set_matrix, 6);
  rb_define_method(rb_cSWFDisplayItem, "get_matrix",
                   rb_SWFDisplayItem_get_matrix, 0);				   
  rb_define_method(rb_cSWFDisplayItem, "get_depth",
                   rb_SWFDisplayItem_get_depth, 0);
  rb_define_method(rb_cSWFDisplayItem, "set_depth",
                   rb_SWFDisplayItem_set_depth, 1);
  rb_define_method(rb_cSWFDisplayItem, "remove",
                   rb_SWFDisplayItem_remove, 0);
  rb_define_method(rb_cSWFDisplayItem, "flush",
                   rb_SWFDisplayItem_flush, 0);		   
  rb_define_method(rb_cSWFDisplayItem, "end_mask",
                   rb_SWFDisplayItem_end_mask, 0);		   
  rb_define_method(rb_cSWFDisplayItem, "set_name",
                   rb_SWFDisplayItem_set_name, 1);
  rb_define_method(rb_cSWFDisplayItem, "set_mask_level",
                   rb_SWFDisplayItem_set_mask_level, 1);
  rb_define_method(rb_cSWFDisplayItem, "set_ratio",
                   rb_SWFDisplayItem_set_ratio, 1);
  rb_define_method(rb_cSWFDisplayItem, "set_cxform",
                   rb_SWFDisplayItem_set_cxform, 1);
  rb_define_method(rb_cSWFDisplayItem, "set_color_add",
                   rb_SWFDisplayItem_set_color_add, -1);
  rb_define_method(rb_cSWFDisplayItem, "set_color_mult",
                   rb_SWFDisplayItem_set_color_mult, -1);
  rb_define_method(rb_cSWFDisplayItem, "cache_as_bitmap",
                   rb_SWFDisplayItem_cache_as_bitmap, 1);
  rb_define_method(rb_cSWFDisplayItem, "set_blend_mode",
                   rb_SWFDisplayItem_set_blend_mode, 1);
  rb_define_method(rb_cSWFDisplayItem, "add_filter",
                   rb_SWFDisplayItem_add_filter, 1);
  rb_define_method(rb_cSWFDisplayItem, "get_character",
                   rb_SWFDisplayItem_get_character, 0);				   
  
  rb_define_alias(rb_cSWFDisplayItem, "add_color", "set_color_add");
  rb_define_alias(rb_cSWFDisplayItem, "mult_color", "set_color_mult");

  return;
}
