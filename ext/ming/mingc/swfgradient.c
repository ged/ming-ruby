/* swfgradient.c	- SWFGradient class
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

VALUE rb_cSWFGradient;

void
rb_free_SWFGradient(p)
	 struct RSWFGradient *p;
{
  destroySWFGradient(p->this);
  return;
}

static VALUE
rb_SWFGradient_s_new(self)
	 VALUE self;
{
  struct RSWFGradient *g = ALLOC(struct RSWFGradient);
  VALUE obj;

  g->this = newSWFGradient();
  
  obj = Data_Wrap_Struct(rb_cSWFGradient, 0,
			 rb_free_SWFGradient, g);

  return obj;
}

static VALUE
rb_SWFGradient_add_entry(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFGradient *p;
  VALUE rt, r, g, b, a;
  float ratio;
  byte red, green, blue, alpha;

  rb_scan_args(argc, argv, "41", &rt, &r, &g, &b, &a);

  ratio = NUM2DBL(rt);
  red   = NUM2CHR(r);
  green = NUM2CHR(g);
  blue  = NUM2CHR(b);

  if (NIL_P(a)) {
	alpha = 0xff;
  } else {
	alpha = NUM2CHR(a);
  }

  Data_Get_Struct(self, struct RSWFGradient, p);
  SWFGradient_addEntry(p->this, ratio, red, green, blue, alpha);

  return self;
}

static VALUE
rb_SWFGradient_set_spread_mode(self, f)
	 VALUE self, f;
{
  struct RSWFGradient *p;

  Data_Get_Struct(self, struct RSWFGradient, p);
  SWFGradient_setSpreadMode(p->this, NUM2INT(f));

  return self;
}

static VALUE
rb_SWFGradient_set_interpolation_mode(self, f)
	 VALUE self, f;
{
  struct RSWFGradient *p;

  Data_Get_Struct(self, struct RSWFGradient, p);
  SWFGradient_setInterpolationMode(p->this, NUM2INT(f));

  return self;
}

static VALUE
rb_SWFGradient_set_focal_point(self, x)
	 VALUE self, x;
{
  struct RSWFGradient *p;

  Data_Get_Struct(self, struct RSWFGradient, p);
  SWFGradient_setFocalPoint(p->this, NUM2DBL(x));
  
  return self;
}

void Init_swfgradient()
{
  rb_cSWFGradient = rb_define_class_under(rb_mMing, "SWFGradient",
					  rb_cObject);

	  /* constants */
  rb_define_const(rb_cSWFGradient, "PAD", 
                           INT2FIX(SWF_GRADIENT_PAD));
  rb_define_const(rb_cSWFGradient, "REFLECT", 
                           INT2FIX(SWF_GRADIENT_REFLECT));		  
  rb_define_const(rb_cSWFGradient, "REPEAT", 
                           INT2FIX(SWF_GRADIENT_REPEAT));
  rb_define_const(rb_cSWFGradient, "NORMAL", 
                           INT2FIX(SWF_GRADIENT_NORMAL));
  rb_define_const(rb_cSWFGradient, "LINEAR", 
                           INT2FIX(SWF_GRADIENT_LINEAR));						   
					  
  rb_define_singleton_method(rb_cSWFGradient, "new",
			     rb_SWFGradient_s_new, 0);
  
  rb_define_method(rb_cSWFGradient, "add_entry",
		   rb_SWFGradient_add_entry, -1);
  rb_define_method(rb_cSWFGradient, "set_spread_mode",
		   rb_SWFGradient_set_spread_mode, 1);
  rb_define_method(rb_cSWFGradient, "set_interpolation_mode",
		   rb_SWFGradient_set_interpolation_mode, 1);   
  rb_define_method(rb_cSWFGradient, "set_focal_point",
		   rb_SWFGradient_set_focal_point, 1);

  return;
}
