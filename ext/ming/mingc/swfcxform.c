/* swfcxform.c  	- SWFCXForm class
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

VALUE rb_cSWFCXform;

void rb_free_SWFCXform(cx)
	 struct RSWFCXform *cx;
{
  destroySWFCXform(cx->this);
  
  return;
}

static VALUE
rb_SWFCXform_new(self, rAdd, gAdd, bAdd, aAdd, rMult, gMult, bMult, aMult)
	 VALUE self, rAdd, gAdd, bAdd, aAdd, rMult, gMult, bMult, aMult;
{
  struct RSWFCXform *cx = ALLOC(struct RSWFCXform);
  VALUE obj;

  cx->this = newSWFCXform(NUM2INT(rAdd), NUM2INT(gAdd), NUM2INT(bAdd), NUM2INT(aAdd),
                          NUM2DBL(rMult), NUM2DBL(gMult), NUM2DBL(bMult), NUM2DBL(aMult));
  if (cx->this == NULL)
    rb_raise(rb_eMingError, "Bad arguments given, need 8 arguments - %s", NULL);
  cx->table = ALLOC(struct References);
  init_references(cx->table);

  obj = Data_Wrap_Struct(rb_cSWFCXform, 0,
			 rb_free_SWFCXform, cx);

  return obj;
}
 
static VALUE
rb_SWFCXform_set_color_add(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  struct RSWFCXform *cx;
  VALUE r, g, b, a;
  int alpha;

  rb_scan_args(argc, argv, "31", &r, &g, &b, &a);
  Data_Get_Struct(self, struct RSWFCXform, cx);
  if NIL_P(a)
    alpha = 0;
  else
    alpha = NUM2INT(a);

  SWFCXform_setColorAdd(cx->this, NUM2INT(r), NUM2INT(g), NUM2INT(b),
                             alpha);
  return self;
}

static VALUE
rb_SWFCXform_set_color_mult(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  struct RSWFCXform *cx;
  VALUE r, g, b, a;
  float alpha;

  rb_scan_args(argc, argv, "31", &r, &g, &b, &a);
  Data_Get_Struct(self, struct RSWFCXform, cx);
  if NIL_P(a)
    alpha = 1.0;
  else
    alpha = NUM2DBL(a);

  SWFCXform_setColorMult(cx->this, NUM2DBL(r), NUM2DBL(g), NUM2DBL(b), alpha);
  return self;
}	 

void Init_swfcxform()
{
  rb_cSWFCXform = rb_define_class_under(rb_mMing, "SWFCXform", 
                                           rb_cObject);
  
  rb_define_singleton_method(rb_cSWFCXform, "new", rb_SWFCXform_new, 8);
  
  rb_define_method(rb_cSWFCXform, "set_color_add",
                   rb_SWFCXform_set_color_add, -1);
  rb_define_method(rb_cSWFCXform, "set_color_mult",
                   rb_SWFCXform_set_color_mult, -1);

  rb_define_alias(rb_cSWFCXform, "add_color", "set_color_add");
  rb_define_alias(rb_cSWFCXform, "mult_color", "set_color_mult");				   
  
  return;
}

