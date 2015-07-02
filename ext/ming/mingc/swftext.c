/* swftext.c	- SWFText class
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

VALUE rb_cSWFText;

void rb_free_SWFText(p)
	 struct RSWFText *p;
{
  destroySWFText(p->this);
  
  return;
}

void rb_mark_SWFText(text)
     struct RSWFText *text;
{
  mark_references(text->table);

  return;
}

static VALUE
rb_SWFText_s_new(self)
	 VALUE self;
{
  struct RSWFText *t = ALLOC(struct RSWFText);
  VALUE obj;

  t->this = newSWFText2();  /* newSWFText2 allows transparency. */
  t->table = ALLOC(struct References);
  init_references(t->table);
  
  obj = Data_Wrap_Struct(rb_cSWFText, rb_mark_SWFText,
			 rb_free_SWFText, t);
  
  return obj;
}

static VALUE
rb_SWFText_set_font(self, font)
     VALUE self, font;
{
  struct RSWFText *p;
  struct RSWFFont *f;
  Data_Get_Struct(self, struct RSWFText, p);
  Data_Get_Struct(font, struct RSWFFont, f);

  SWFText_setFont(p->this, f->this);
  add_references(p->table, font);
  
  return self;
}

static VALUE
rb_SWFText_set_height(self, h)
	 VALUE self, h;
{
  struct RSWFText *p;

  Data_Get_Struct(self, struct RSWFText, p);
  SWFText_setHeight(p->this, NUM2DBL(h));
  
  return self;
}

static VALUE 
rb_SWFText_set_color(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFText *p;
  VALUE r, g, b, a;
  byte red, green, blue, alpha;

  rb_scan_args(argc, argv, "31", &r, &g, &b, &a);

  red   = NUM2CHR(r);
  green = NUM2CHR(g);
  blue  = NUM2CHR(b);

  if(NIL_P(a)) {
	alpha = 0xff;
  } else {
	alpha = NUM2CHR(a);
  }
  
  Data_Get_Struct(self, struct RSWFText, p);
  SWFText_setColor(p->this, red, green, blue, alpha);
  
  return self;
}

static VALUE
rb_SWFText_move_to(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFText *p;

  Data_Get_Struct(self, struct RSWFText, p);
  SWFText_moveTo(p->this, NUM2DBL(x), NUM2DBL(y));
  
  return self;
}

static VALUE
rb_SWFText_add_string(self, s)
	 VALUE self, s;
{
  struct RSWFText *p;

  Data_Get_Struct(self, struct RSWFText, p);

  SWFText_addString(p->this, StringValuePtr(s), NULL);
  return self;
}

static VALUE
rb_SWFText_add_UTF8_string(int argc, VALUE *argv, VALUE self)
{
  VALUE s, advance;
  struct RSWFText *p;
  int *adv;
  size_t len, i;

  rb_scan_args(argc, argv, "11", &s, &advance);
  if (advance == Qnil) {
    adv = 0;
  } else {
    len = RARRAY(advance)->len;
    adv = ALLOC_N(int, len);
    
    /* unefficient, but easy to implement... */
    for (i = 0; i < len; i++) {
      adv[i] = NUM2INT(rb_ary_entry(advance, i));
    }
  }

  Data_Get_Struct(self, struct RSWFText, p);
  SWFText_addUTF8String(p->this, StringValuePtr(s), adv);
  return self;
}


static VALUE
rb_SWFText_set_spacing(self, s)
	 VALUE self, s;
{
  struct RSWFText *p;

  Data_Get_Struct(self, struct RSWFText, p);
  SWFText_setSpacing(p->this, NUM2DBL(s));
  
  return self;
}

static VALUE
rb_SWFText_get_string_width(self, s)
     VALUE self, s;
{
  struct RSWFText *p;

  Data_Get_Struct(self, struct RSWFText, p);
  return rb_float_new(SWFText_getStringWidth(p->this, StringValuePtr(s)));
}

static VALUE
rb_SWFText_get_UTF8_string_width(self, s)
     VALUE self, s;
{
  struct RSWFText *p;

  Data_Get_Struct(self, struct RSWFText, p);
  return rb_float_new(SWFText_getUTF8StringWidth(p->this, StringValuePtr(s)));
}

static VALUE
rb_SWFText_get_ascent(self)
	 VALUE self;
{
  struct RSWFText *p;

  Data_Get_Struct(self, struct RSWFText, p);
  return rb_float_new(SWFText_getAscent(p->this));
}

static VALUE
rb_SWFText_get_leading(self)
	 VALUE self;
{
  struct RSWFText *p;

  Data_Get_Struct(self, struct RSWFText, p);
  return rb_float_new(SWFText_getLeading(p->this));
}

static VALUE
rb_SWFText_get_descent(self)
	 VALUE self;
{
  struct RSWFText *p;

  Data_Get_Struct(self, struct RSWFText, p);
  return rb_float_new(SWFText_getDescent(p->this));
}

void Init_swftext()
{
  rb_cSWFText = rb_define_class_under(rb_mMing, "SWFText", rb_cObject);

  rb_define_singleton_method(rb_cSWFText, "new", rb_SWFText_s_new, 0);

  rb_define_method(rb_cSWFText, "set_font",
				   rb_SWFText_set_font, 1);
  rb_define_method(rb_cSWFText, "set_height",
				   rb_SWFText_set_height, 1);
  rb_define_method(rb_cSWFText, "set_color",
				   rb_SWFText_set_color, -1);
  rb_define_method(rb_cSWFText, "move_to",
				   rb_SWFText_move_to, 2);
  rb_define_alias(rb_cSWFText, "set_x_y", "move_to");
  rb_define_method(rb_cSWFText, "add_string",
                   rb_SWFText_add_string, 1);
  rb_define_method(rb_cSWFText, "add_UTF8_string",
                   rb_SWFText_add_UTF8_string, -1);
  rb_define_method(rb_cSWFText, "set_spacing",
                   rb_SWFText_set_spacing, 1);
  rb_define_method(rb_cSWFText, "get_string_width",
                   rb_SWFText_get_string_width, 1);
  rb_define_alias(rb_cSWFText, "get_width", "get_string_width");
  rb_define_method(rb_cSWFText, "get_UTF8_string_width",
                   rb_SWFText_get_UTF8_string_width, 1);
  rb_define_method(rb_cSWFText, "get_ascent",
				   rb_SWFText_get_ascent, 0);
  rb_define_method(rb_cSWFText, "get_leading",
				   rb_SWFText_get_leading, 0);
  rb_define_method(rb_cSWFText, "get_descent",
				   rb_SWFText_get_descent, 0);

  /* 
  rb_define_method(rb_cSWFText, "add_wide_string",
                   rb_SWFText_add_wide_string, 3);
  rb_define_method(rb_cSWFText, "get_string_wide_width",
                   rb_SWFText_get_string_wide_width, 1);
  */

  return;
}

