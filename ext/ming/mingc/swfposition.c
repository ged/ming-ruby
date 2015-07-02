/* swfposition.c   	- SWFPosition class
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

VALUE rb_cSWFPosition;

void rb_free_SWFPosition(p)
	 struct RSWFPosition *p;
{
  destroySWFPosition(p->this);
  
  return;
}

static void rb_mark_SWFPosition(position)
     struct RSWFPosition *position;
{
  mark_references(position->table);
  return;
}

static VALUE
rb_SWFPosition_skew_x(self, x)
	 VALUE self, x;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_skewX(p->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFPosition_skew_y(self, x)
	 VALUE self, x;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_skewY(p->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFPosition_skew_x_to(self, x)
	 VALUE self, x;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_skewXTo(p->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFPosition_skew_y_to(self, x)
	 VALUE self, x;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_skewYTo(p->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFPosition_scale_x(self, x)
	 VALUE self, x;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_scaleX(p->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFPosition_scale_y(self, x)
	 VALUE self, x;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_scaleY(p->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFPosition_scale_x_to(self, x)
	 VALUE self, x;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_scaleXTo(p->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFPosition_scale_y_to(self, x)
	 VALUE self, x;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_scaleYTo(p->this, NUM2DBL(x));

  return self;
}

static VALUE
rb_SWFPosition_scale(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_scaleXY(p->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFPosition_scale_to(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  VALUE x, y;
  struct RSWFPosition *p;

  rb_scan_args(argc, argv, "11", &x, &y);

  Data_Get_Struct(self, struct RSWFPosition, p);

  if (NIL_P(y))
    SWFPosition_scaleXYTo(p->this, NUM2DBL(x), NUM2DBL(x));
  else
    SWFPosition_scaleXYTo(p->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFPosition_rotate(self, d)
	 VALUE self, d;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_rotate(p->this, NUM2DBL(d));

  return self;
}

static VALUE
rb_SWFPosition_rotate_to(self, d)
	 VALUE self, d;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_rotateTo(p->this, NUM2DBL(d));

  return self;
}

static VALUE
rb_SWFPosition_move(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_move(p->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFPosition_move_to(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);
  SWFPosition_moveTo(p->this, NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFPosition_set_matrix(self, a, b, c, d, x, y)
	 VALUE self, a, b, c, d, x, y;
{
  struct RSWFPosition *p;

  Data_Get_Struct(self, struct RSWFPosition, p);

  SWFPosition_setMatrix(p->this, NUM2DBL(a), NUM2DBL(b),
			   NUM2DBL(c), NUM2DBL(d),
			   NUM2DBL(x), NUM2DBL(y));

  return self;
}

static VALUE
rb_SWFPosition_get_matrix(self)
	 VALUE self;
{
  struct RSWFPosition *p;
  struct RSWFMatrix *m = ALLOC(struct RSWFMatrix);
  VALUE obj;
  
  Data_Get_Struct(self, struct RSWFPosition, p);
  m->this = SWFPosition_getMatrix(p->this);
  m->table = ALLOC(struct References);
  init_references(m->table);
	
  obj = Data_Wrap_Struct(rb_cSWFMatrix, NULL,
				-1, m);
			 
  add_references(m->table, obj);

  return obj;
}

void Init_swfposition()
{
  rb_cSWFPosition = rb_define_class_under(rb_mMing, "SWFPosition", 
                                           rb_cObject);
  
  rb_define_method(rb_cSWFPosition, "skew_x",
                   rb_SWFPosition_skew_x, 1);
  rb_define_method(rb_cSWFPosition, "skew_y",
                   rb_SWFPosition_skew_y, 1);				  
  rb_define_method(rb_cSWFPosition, "skew_x_to",
                   rb_SWFPosition_skew_x_to, 1);
  rb_define_method(rb_cSWFPosition, "skew_y_to",
                   rb_SWFPosition_skew_y_to, 1);	
  rb_define_method(rb_cSWFPosition, "scale_x",
                   rb_SWFPosition_scale_x, 1);
  rb_define_method(rb_cSWFPosition, "scale_y",
                   rb_SWFPosition_scale_y, 1);				  
  rb_define_method(rb_cSWFPosition, "scale_x_to",
                   rb_SWFPosition_scale_x_to, 1);
  rb_define_method(rb_cSWFPosition, "scale_y_to",
                   rb_SWFPosition_scale_y_to, 1);	
  rb_define_method(rb_cSWFPosition, "scale",
                   rb_SWFPosition_scale, 2);
  rb_define_method(rb_cSWFPosition, "scale_to",
                   rb_SWFPosition_scale_to, 2);
  rb_define_method(rb_cSWFPosition, "rotate",
                   rb_SWFPosition_rotate, 1);				 
  rb_define_method(rb_cSWFPosition, "rotate_to",
                   rb_SWFPosition_rotate_to, 1);	
  rb_define_method(rb_cSWFPosition, "move",
                   rb_SWFPosition_move, 2);
  rb_define_method(rb_cSWFPosition, "move_to",
                   rb_SWFPosition_move_to, 2);
  rb_define_method(rb_cSWFPosition, "set_matrix",
                   rb_SWFPosition_set_matrix, 6);						   
  rb_define_method(rb_cSWFPosition, "get_matrix",
                   rb_SWFPosition_get_matrix, 1);				   
  return;
}

