/* swfmatrix.c   	- SWFMatrix class
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

VALUE rb_cSWFMatrix;

static VALUE
rb_SWFMatrix_new_position(self)
     VALUE self;
{
  struct RSWFMatrix *m;
  struct RSWFPosition *p = ALLOC(struct RSWFPosition);
  VALUE obj;

  Data_Get_Struct(self, struct RSWFMatrix, m);

  p->this = newSWFPosition(m->this);
  p->table = ALLOC(struct References);
  init_references(p->table);

  obj = Data_Wrap_Struct(rb_cSWFPosition, 
                         0, rb_free_SWFPosition, p);
  add_references(m->table, obj);
  return obj;
}


static VALUE
rb_SWFMatrix_get_scale_x(self)
     VALUE self;
{
  struct RSWFMatrix *m;
  
  Data_Get_Struct(self, struct RSWFMatrix, m);
  return rb_float_new(SWFMatrix_getScaleX(m->this));
}

static VALUE
rb_SWFMatrix_get_scale_y(self)
     VALUE self;
{
  struct RSWFMatrix *m;
  
  Data_Get_Struct(self, struct RSWFMatrix, m);
  return rb_float_new(SWFMatrix_getScaleY(m->this));
}

static VALUE
rb_SWFMatrix_get_rotate_0(self)
     VALUE self;
{
  struct RSWFMatrix *m;
  
  Data_Get_Struct(self, struct RSWFMatrix, m);
  return rb_float_new(SWFMatrix_getRotate0(m->this));
}

static VALUE
rb_SWFMatrix_get_rotate_1(self)
     VALUE self;
{
  struct RSWFMatrix *m;
  
  Data_Get_Struct(self, struct RSWFMatrix, m);
  return rb_float_new(SWFMatrix_getRotate1(m->this));
}

static VALUE
rb_SWFMatrix_get_translate_x(self)
	 VALUE self;
{
  struct RSWFMatrix *m;
  
  Data_Get_Struct(self, struct RSWFMatrix, m);

  return INT2NUM(SWFMatrix_getTranslateX(m->this));
}

static VALUE
rb_SWFMatrix_get_translate_y(self)
	 VALUE self;
{
  struct RSWFMatrix *m;
  
  Data_Get_Struct(self, struct RSWFMatrix, m);

  return INT2NUM(SWFMatrix_getTranslateY(m->this));
}


void Init_swfmatrix()
{
  rb_cSWFMatrix = rb_define_class_under(rb_mMing, "SWFMatrix", 
                                           rb_cObject);
  
  rb_define_method(rb_cSWFMatrix, "position_from_matrix",
                   rb_SWFMatrix_new_position, 0);
  rb_define_method(rb_cSWFMatrix, "get_scale_x",
                   rb_SWFMatrix_get_scale_x, 0);
  rb_define_method(rb_cSWFMatrix, "get_scale_y",
                   rb_SWFMatrix_get_scale_y, 0);
  rb_define_method(rb_cSWFMatrix, "get_rotate_0",
                   rb_SWFMatrix_get_rotate_0, 0);  
  rb_define_method(rb_cSWFMatrix, "get_rotate_1",
                   rb_SWFMatrix_get_rotate_1, 0);
  rb_define_method(rb_cSWFMatrix, "get_translate_x",
                   rb_SWFMatrix_get_translate_x, 0);
  rb_define_method(rb_cSWFMatrix, "get_translate_y",
                   rb_SWFMatrix_get_translate_y, 0);				   
  return;
}

