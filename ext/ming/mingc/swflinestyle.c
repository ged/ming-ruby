/* swflinestyle.c 	- SWFLineStyle class
 * $Id$
 *
 * Copyright (C) 2008 Pawel Karwowski
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

VALUE rb_cSWFLineStyle;

void rb_free_SWFLineStyle(p)
	 struct RSWFLineStyle *p;
{
  free(p->this);
  
  return;
}

static VALUE 
rb_SWFLineStyle_set_line_style(argc, argv, self)
	int argc; 
	VALUE *argv, self;
{
  struct RSWFLineStyle *ls = ALLOC(struct RSWFLineStyle);
  VALUE obj, w, r, g, b, a;
  unsigned short width;
  byte red, green, blue, alpha;
  
  rb_scan_args(argc, argv, "41", &w, &r, &g, &b,&a);

  width = FIX2UINT(w);
  red   = NUM2CHR(r);
  green = NUM2CHR(g);
  blue  = NUM2CHR(b);
  alpha = NUM2CHR(a);
  
  if(NIL_P(a)) {
    alpha = 0xff;
  } else {
    alpha = NUM2CHR(a);
  }
  
  ls->this = newSWFLineStyle(width, red, green, blue, alpha);
  
  if (ls->this == NULL)
  rb_raise(rb_eMingError, "Bad arguments given, need 4 or 5 arguments - %s", NULL);
  
  ls->table = ALLOC(struct References);
  init_references(ls->table);
  
  obj = Data_Wrap_Struct(rb_cSWFLineStyle, 0, rb_free_SWFLineStyle, ls);
  
  return obj;
}


static VALUE 
rb_SWFLineStyle_set_line_style_2(argc, argv, self)
	int argc; 
	VALUE *argv, self;
{
  struct RSWFLineStyle *ls = ALLOC(struct RSWFLineStyle);
  VALUE obj, w, r, g, b, a, f, m;
  unsigned short width;
  byte red, green, blue, alpha;
  int flags;
  float ml;
  
  rb_scan_args(argc, argv, "70", &w, &r, &g, &b, &a, &f, &m);

  width = FIX2UINT(w);
  red   = NUM2CHR(r);
  green = NUM2CHR(g);
  blue  = NUM2CHR(b);
  alpha = NUM2CHR(a);
  flags  = NUM2INT(f);
  ml    = NUM2DBL(m);
  
  ls->this = newSWFLineStyle2(width, red, green, blue, alpha, flags, ml);
  
  if (ls->this == NULL)
  rb_raise(rb_eMingError, "Bad arguments given, need 7 arguments - %s", NULL);
  
  ls->table = ALLOC(struct References);
  init_references(ls->table);
  
  obj = Data_Wrap_Struct(rb_cSWFLineStyle, 0, rb_free_SWFLineStyle, ls);
  
  return obj;
}



void Init_swflinestyle()
{
  rb_cSWFLineStyle = rb_define_class_under(rb_mMing, "SWFLineStyle", rb_cObject);
  
  

  rb_define_const(rb_cSWFLineStyle, "CAP_ROUND", 
                           INT2FIX(SWF_LINESTYLE_CAP_ROUND));
  rb_define_const(rb_cSWFLineStyle, "CAP_NONE", 
                           INT2FIX(SWF_LINESTYLE_CAP_NONE));			   
  rb_define_const(rb_cSWFLineStyle, "CAP_SQUARE", 
                           INT2FIX(SWF_LINESTYLE_CAP_SQUARE));
  rb_define_const(rb_cSWFLineStyle, "JOIN_ROUND", 
                           INT2FIX(SWF_LINESTYLE_JOIN_ROUND));
  rb_define_const(rb_cSWFLineStyle, "JOIN_BEVEL", 
                           INT2FIX(SWF_LINESTYLE_JOIN_BEVEL));			   
  rb_define_const(rb_cSWFLineStyle, "JOIN_MITER", 
                           INT2FIX(SWF_LINESTYLE_JOIN_MITER));
  rb_define_const(rb_cSWFLineStyle, "FLAG_NOHSCALE", 
                           INT2FIX(SWF_LINESTYLE_FLAG_NOHSCALE));
  rb_define_const(rb_cSWFLineStyle, "FLAG_NOVSCALE", 
                           INT2FIX(SWF_LINESTYLE_FLAG_NOVSCALE));
  rb_define_const(rb_cSWFLineStyle, "FLAG_HINTING", 
                           INT2FIX(SWF_LINESTYLE_FLAG_HINTING));			   
  rb_define_const(rb_cSWFLineStyle, "FLAG_NOCLOSE", 
                           INT2FIX(SWF_LINESTYLE_FLAG_NOCLOSE));
  rb_define_const(rb_cSWFLineStyle, "FLAG_ENDCAP_ROUND", 
                           INT2FIX(SWF_LINESTYLE_FLAG_ENDCAP_ROUND));
  rb_define_const(rb_cSWFLineStyle, "FLAG_ENDCAP_NONE", 
                           INT2FIX(SWF_LINESTYLE_FLAG_ENDCAP_NONE));
  rb_define_const(rb_cSWFLineStyle, "FLAG_ENDCAP_SQUARE", 
                           INT2FIX(SWF_LINESTYLE_FLAG_ENDCAP_SQUARE));			   

  rb_define_singleton_method(rb_cSWFLineStyle, "set_line_style", rb_SWFLineStyle_set_line_style, -1);

  rb_define_singleton_method(rb_cSWFLineStyle, "set_line_style_2", rb_SWFLineStyle_set_line_style_2, -1);

  return;
}
