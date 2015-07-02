/* swftextfield.c	- SWFTextField class
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

VALUE rb_cSWFTextField;

void
rb_free_SWFTextField(p)
     struct RSWFTextField *p;
{
  destroySWFTextField(p->this);

  return;
}

void rb_SWFTextField_mark(text)
     struct RSWFTextField *text;
{
  mark_references(text->table);
  return;
}

static VALUE
rb_SWFTextField_s_new(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  VALUE obj, flags;
  struct RSWFTextField *t = ALLOC(struct RSWFTextField);

  rb_scan_args(argc, argv, "01", &flags);
  
  t->this = newSWFTextField();
  t->table = ALLOC(struct References);
  init_references(t->table);

  if (! NIL_P(flags))
    SWFTextField_setFlags(t->this, NUM2INT(flags));
	  
  obj = Data_Wrap_Struct(rb_cSWFTextField, rb_SWFTextField_mark,
                         rb_free_SWFTextField, t);

  return obj;
}

static VALUE
rb_SWFTextField_set_font(self, font)
     VALUE self, font;
{
  struct RSWFTextField *t;
  struct RSWFBlock *f;

  Data_Get_Struct(self, struct RSWFTextField, t);
  Data_Get_Struct(font, struct RSWFBlock, f);

  add_references(t->table, font);
  SWFTextField_setFont(t->this, f->this);

  return self;
}

static VALUE
rb_SWFTextField_set_bounds(self, w, h)
     VALUE self, w, h;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setBounds(t->this, NUM2DBL(w), NUM2DBL(h));

  return self;
}

static VALUE
rb_SWFTextField_set_flags(self, f)
     VALUE self, f;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setFlags(t->this, FIX2INT(f));

  return self;
}

static VALUE
rb_SWFTextField_set_color(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  struct RSWFTextField *t;
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
    
  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setColor(t->this, red, green, blue, alpha);

  return self; 
}

static VALUE
rb_SWFTextField_set_variable_name(self, n)
	 VALUE self, n;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setVariableName(t->this, StringValuePtr(n));

  return self;
}

static VALUE
rb_SWFTextField_add_string(self, s)
	 VALUE self, s;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_addString(t->this, StringValuePtr(s));

  return self;
}

static VALUE
rb_SWFTextField_add_UTF8_string(self, s)
	 VALUE self, s;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_addUTF8String(t->this, StringValuePtr(s));

  return self;
}

static VALUE
rb_SWFTextField_set_height(self, h)
	 VALUE self, h;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setHeight(t->this, NUM2DBL(h));

  return self;
}

static VALUE
rb_SWFTextField_set_field_height(self, h)
	 VALUE self, h;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setFieldHeight(t->this, NUM2DBL(h));

  return self;
}

static VALUE
rb_SWFTextField_set_left_margin(self, l)
	 VALUE self, l;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setLeftMargin(t->this, NUM2DBL(l));

  return self;
}

static VALUE
rb_SWFTextField_set_right_margin(self, r)
	 VALUE self, r;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setRightMargin(t->this, NUM2DBL(r));

  return self;
}

static VALUE
rb_SWFTextField_set_margins(self, l, r)
	 VALUE self, l, r;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setLeftMargin(t->this, NUM2DBL(l));
  SWFTextField_setRightMargin(t->this, NUM2DBL(r));

  return self;
}

static VALUE
rb_SWFTextField_set_indentation(self, w)
	 VALUE self, w;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setIndentation(t->this, NUM2DBL(w));

  return self;
}

static VALUE
rb_SWFTextField_set_line_spacing(self, l)
	 VALUE self, l;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setLineSpacing(t->this, NUM2DBL(l));

  return self;
}

static VALUE
rb_SWFTextField_set_padding(self, l)
	 VALUE self, l;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setPadding(t->this, NUM2DBL(l));

  return self;
}

static VALUE
rb_SWFTextField_add_chars(self, s)
	 VALUE self, s;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_addChars(t->this, StringValuePtr(s));

  return self;
}

static VALUE
rb_SWFTextField_set_alignment(self, f)
	 VALUE self, f;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setAlignment(t->this, NUM2INT(f));

  return self;
}

static VALUE
rb_SWFTextField_set_length(self, l)
	 VALUE self, l;
{
  struct RSWFTextField *t;

  Data_Get_Struct(self, struct RSWFTextField, t);
  SWFTextField_setLength(t->this, FIX2INT(l));

  return self;
}


void
Init_swftextfield()
{
  rb_cSWFTextField = rb_define_class_under(rb_mMing, "SWFTextField",
					   rb_cObject);  

  rb_define_const(rb_cSWFTextField, "HAS_FONT", 
                  INT2FIX(SWFTEXTFIELD_HASFONT));
  rb_define_const(rb_cSWFTextField, "HAS_LENGTH", 
                  INT2FIX(SWFTEXTFIELD_HASLENGTH));
  rb_define_const(rb_cSWFTextField, "HAS_COLOR", 
                  INT2FIX(SWFTEXTFIELD_HASCOLOR));
  rb_define_const(rb_cSWFTextField, "NO_EDIT", 
                  INT2FIX(SWFTEXTFIELD_NOEDIT));
  rb_define_const(rb_cSWFTextField, "PASSWORD", 
                  INT2FIX(SWFTEXTFIELD_PASSWORD));
  rb_define_const(rb_cSWFTextField, "WORDWRAP", 
                  INT2FIX(SWFTEXTFIELD_WORDWRAP));
  rb_define_const(rb_cSWFTextField, "MULTILINE", 
                  INT2FIX(SWFTEXTFIELD_MULTILINE));
  rb_define_const(rb_cSWFTextField, "HAS_TEXT", 
                  INT2FIX(SWFTEXTFIELD_HASTEXT));
  rb_define_const(rb_cSWFTextField, "USE_FONT", 
                  INT2FIX(SWFTEXTFIELD_USEFONT));
  rb_define_const(rb_cSWFTextField, "HTML", 
                  INT2FIX(SWFTEXTFIELD_HTML));
  rb_define_const(rb_cSWFTextField, "DRAW_BOX",
                  INT2FIX(SWFTEXTFIELD_DRAWBOX));
  rb_define_const(rb_cSWFTextField, "NO_SELECT",
                  INT2FIX(SWFTEXTFIELD_NOSELECT));
  rb_define_const(rb_cSWFTextField, "HAS_LAYOUT",
                  INT2FIX(SWFTEXTFIELD_HASLAYOUT));
  rb_define_const(rb_cSWFTextField, "AUTO_SIZE",
                  INT2FIX(SWFTEXTFIELD_AUTOSIZE));
  rb_define_const(rb_cSWFTextField, "ALIGN_LEFT",
                  INT2FIX(SWFTEXTFIELD_ALIGN_LEFT));
  rb_define_const(rb_cSWFTextField, "ALIGN_RIGHT",
                  INT2FIX(SWFTEXTFIELD_ALIGN_RIGHT));
  rb_define_const(rb_cSWFTextField, "ALIGN_CENTER",
                  INT2FIX(SWFTEXTFIELD_ALIGN_CENTER));
  rb_define_const(rb_cSWFTextField, "ALIGN_JUSTIFY",
                  INT2FIX(SWFTEXTFIELD_ALIGN_JUSTIFY));


  rb_define_singleton_method(rb_cSWFTextField, "new",
                             rb_SWFTextField_s_new, -1);


  rb_define_method(rb_cSWFTextField, "set_font",
                   rb_SWFTextField_set_font, 1);
  rb_define_method(rb_cSWFTextField, "set_bounds",
                   rb_SWFTextField_set_bounds, 2);
  rb_define_method(rb_cSWFTextField, "set_color",
                   rb_SWFTextField_set_color, -1);
  rb_define_method(rb_cSWFTextField, "set_flags",
                   rb_SWFTextField_set_flags, 1);
  rb_define_method(rb_cSWFTextField, "set_variable_name",
                   rb_SWFTextField_set_variable_name, 1);
  rb_define_method(rb_cSWFTextField, "add_string",
                   rb_SWFTextField_add_string, 1);
  rb_define_method(rb_cSWFTextField, "add_UTF8_string",
                   rb_SWFTextField_add_UTF8_string, 1);
  rb_define_method(rb_cSWFTextField, "set_height",
                   rb_SWFTextField_set_height, 1);
  rb_define_method(rb_cSWFTextField, "set_field_height",
                   rb_SWFTextField_set_field_height, 1);
  rb_define_method(rb_cSWFTextField, "set_left_margin",
                   rb_SWFTextField_set_left_margin, 1);
  rb_define_method(rb_cSWFTextField, "set_right_margin",
                   rb_SWFTextField_set_right_margin, 1);
  rb_define_method(rb_cSWFTextField, "set_margins",
                   rb_SWFTextField_set_margins, 2);
  rb_define_method(rb_cSWFTextField, "set_indentation",
                   rb_SWFTextField_set_indentation, 1);
  rb_define_method(rb_cSWFTextField, "set_line_spacing",
                   rb_SWFTextField_set_line_spacing, 1);
  rb_define_method(rb_cSWFTextField, "set_padding",
                   rb_SWFTextField_set_padding, 1);
  rb_define_method(rb_cSWFTextField, "add_chars",
                   rb_SWFTextField_add_chars, 1);
  rb_define_method(rb_cSWFTextField, "set_alignment",
                   rb_SWFTextField_set_alignment, 1);
  rb_define_method(rb_cSWFTextField, "set_length",
                   rb_SWFTextField_set_length, 1);
		   
  rb_define_alias(rb_cSWFTextField, "set_name", "set_variable_name");

  return;
}
