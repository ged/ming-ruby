/* swfcolor.c     	- SWFColor class
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

VALUE rb_cSWFColor;

void rb_free_SWFColor(c)
	 struct RSWFColor *c;
{
  free(c); 
  
  return;
}

static VALUE
rb_SWFColor_new(argc, argv, self)
   int argc;
   VALUE *argv, self;
{
  SWFColor *c;
  VALUE r, g, b, a;
  c = ALLOC(struct SWFColor);
  VALUE obj;
  byte red, green, blue, alpha;

  rb_scan_args(argc, argv, "31", &r, &g, &b, &a);
  
   c->red = NUM2CHR(r);
   c->green = NUM2CHR(g);
   c->blue = NUM2CHR(b);
  
  if(NIL_P(a)) {
    c->alpha = 0xff;
  } else {
	c->alpha = NUM2CHR(a);
  }

  obj = Data_Wrap_Struct(rb_cSWFColor, NULL, 
			    rb_free_SWFColor, c);
  return obj;
}

void Init_swfcolor()
{
  rb_cSWFColor = rb_define_class_under(rb_mMing, "SWFColor", 
                                           rb_cObject);
  
  rb_define_singleton_method(rb_cSWFColor, "new", rb_SWFColor_new, -1);
  
 
  return;
}
