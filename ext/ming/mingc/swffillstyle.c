/* swffillstyle.c	- SWFFillStyle class
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

VALUE rb_cSWFFillStyle;

void rb_free_SWFFillStyle(fstyle)
	 struct RSWFFillStyle *fstyle;
{
  destroySWFFillStyle(fstyle->this);
  
  return;
}

static void rb_mark_SWFFillStyle(fstyle)
     struct RSWFFillStyle *fstyle;
{
  mark_references(fstyle->table);
  return;
}
 
static VALUE 
rb_SWFFillStyle_s_new(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFFillStyle *fstyle = ALLOC(struct RSWFFillStyle);
  VALUE opt[4], obj;
  byte red, green, blue, alpha, flags;
  
  rb_scan_args(argc, argv, "13", &opt[0], &opt[1], &opt[2], &opt[3]);

  fstyle->table = ALLOC(struct References);
  init_references(fstyle->table);

  if(rb_obj_is_kind_of(opt[0], rb_cNumeric)) {
	red   = NUM2CHR(opt[0]);
	green = NUM2CHR(opt[1]);
	blue  = NUM2CHR(opt[2]);

	if(NIL_P(opt[3])) {
	  alpha = 0xff;
	} else {
	  alpha = NUM2CHR(opt[3]);
	}

	fstyle->this = newSWFSolidFillStyle(red, green, blue, alpha);
  } else if (rb_obj_is_kind_of(opt[0], rb_cSWFBitmap)) {
	struct RSWFBitmap *b;

	Data_Get_Struct(opt[0], struct RSWFBitmap, b);
	if(NIL_P(opt[1])) {
	  flags = 0;
	} else {
	  flags = NUM2CHR(opt[1]);
	}
	add_references(fstyle->table, opt[0]);
	fstyle->this = newSWFBitmapFillStyle(b->this, flags);
  } else if (rb_obj_is_kind_of(opt[0], rb_cSWFGradient)) {
	struct RSWFGradient *b;

	Data_Get_Struct(opt[0], struct RSWFGradient, b);
	if(NIL_P(opt[1])) {
	  flags = 0;
	} else {
	  flags = NUM2CHR(opt[1]);
	}
	add_references(fstyle->table, opt[0]);
	fstyle->this = newSWFGradientFillStyle(b->this, flags);
  } else {
	rb_raise(rb_eMingError,
		 "addFill: argument is not a bitmap nor a gradient.");
  }


  obj = Data_Wrap_Struct(rb_cSWFFillStyle, rb_mark_SWFFillStyle,
			 rb_free_SWFFillStyle, fstyle);

  return obj;
}

static VALUE
rb_SWFFillStyle_s_fill(self)
     VALUE self;
{
  struct RSWFFillStyle *fstyle;
  struct RSWFFill *fill = ALLOC(struct RSWFFill);
  VALUE obj;

  Data_Get_Struct(self, struct RSWFFillStyle, fstyle);

  fill->this = newSWFFill(fstyle->this);

  obj = Data_Wrap_Struct(rb_cSWFFill, NULL,
			 rb_free_SWFFill, fill);
			 
  add_references(fstyle->table, obj);			 

  return obj;
}	 
 
void Init_swffillstyle()
{
  rb_cSWFFillStyle = rb_define_class_under(rb_mMing, "SWFFillStyle", 
                                           rb_cObject);
  rb_define_singleton_method(rb_cSWFFillStyle, "new", rb_SWFFillStyle_s_new, -1);
  rb_define_method(rb_cSWFFillStyle, "fill_from_fillstyle", rb_SWFFillStyle_s_fill, 0);
  
  return;
}

