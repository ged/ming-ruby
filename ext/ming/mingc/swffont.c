/* swffont.c	- SWFFont class
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

VALUE rb_cSWFFont;

void
rb_free_SWFFont(p)
     struct RSWFFont *p;
{

  destroySWFFont(p->this);

  return;
}

static VALUE
rb_SWFFont_s_new_from_file(self, filename)
	 VALUE self, filename;
{
  struct RSWFFont *f = ALLOC(struct RSWFFont);
  VALUE obj;

  f->this  = newSWFFont_fromFile(StringValuePtr(filename));
  f->table = ALLOC(struct References);
  init_references(f->table);
  obj = Data_Wrap_Struct(rb_cSWFFont, 0,
			 rb_free_SWFFont, f);

  return obj;
}

static VALUE
rb_SWFFont_get_string_width(self, s)
	 VALUE self, s;
{
  struct RSWFFont *f;

  Data_Get_Struct(self, struct RSWFFont, f);

  return rb_float_new(SWFFont_getStringWidth(f->this, StringValuePtr(s)));
}

static VALUE
rb_SWFFont_get_utf8_string_width(self, s)
	 VALUE self, s;
{
  struct RSWFFont *f;

  Data_Get_Struct(self, struct RSWFFont, f);

  return rb_float_new(SWFFont_getUTF8StringWidth(f->this, StringValuePtr(s)));
}

static VALUE
rb_SWFFont_get_ascent(self)
	 VALUE self;
{
  struct RSWFFont *f;

  Data_Get_Struct(self, struct RSWFFont, f);

  return rb_float_new(SWFFont_getAscent(f->this));
}

static VALUE
rb_SWFFont_get_descent(self)
	 VALUE self;
{
  struct RSWFFont *f;

  Data_Get_Struct(self, struct RSWFFont, f);

  return rb_float_new(SWFFont_getDescent(f->this));
}

static VALUE
rb_SWFFont_get_leading(self)
	 VALUE self;
{
  struct RSWFFont *f;

  Data_Get_Struct(self, struct RSWFFont, f);

  return rb_float_new(SWFFont_getLeading(f->this));
}


static VALUE
rb_SWFFont_get_glyph_count(self)
	 VALUE self;
{
  struct RSWFFont *f;

  Data_Get_Struct(self, struct RSWFFont, f);

  return rb_int_new(SWFFont_getGlyphCount(f->this));
}


static VALUE
rb_SWFFont_get_name(self)
	 VALUE self;
{
  struct RSWFFont *f;

  Data_Get_Struct(self, struct RSWFFont, f);
  return rb_str_new2(SWFFont_getName(f->this));
}



void Init_swffont()
{
  rb_cSWFFont = rb_define_class_under(rb_mMing, "SWFFont", 
                                      rb_cObject);

  rb_define_singleton_method(rb_cSWFFont, "new_from_file", 
                             rb_SWFFont_s_new_from_file, 1);
  rb_define_method(rb_cSWFFont, "get_string_width",
                   rb_SWFFont_get_string_width, 1);
  rb_define_alias(rb_cSWFFont, "get_width", "get_string_width");
  rb_define_method(rb_cSWFFont, "get_UTF8_string_width",
                   rb_SWFFont_get_utf8_string_width, 1);
  rb_define_method(rb_cSWFFont, "get_ascent",
                   rb_SWFFont_get_ascent, 0);
  rb_define_method(rb_cSWFFont, "get_descent",
                   rb_SWFFont_get_descent, 0);
  rb_define_method(rb_cSWFFont, "get_leading",
                   rb_SWFFont_get_leading, 0);
  rb_define_method(rb_cSWFFont, "get_glyph_count",
                   rb_SWFFont_get_glyph_count, 0);
  rb_define_method(rb_cSWFFont, "get_name",
                   rb_SWFFont_get_name, 0);		   

  return;
}
