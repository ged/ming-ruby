/* swfshape.c	- SWFShape class
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

#if !defined(SWF_SHAPE_USENONSCALINGSTREOKES)
# define SWF_SHAPE_USENONSCALINGSTREOKES SWF_SHAPE_USENONSCALINGSTROKES
#endif	// !SWF_SHAPE_USENONSCALINGSTREOKES

VALUE rb_cSWFShape;

void rb_free_SWFShape(p)
	 struct RSWFShape *p;
{
  destroySWFShape(p->this); 
  
  return;
}

void rb_mark_SWFShape(shape)
     struct RSWFShape *shape;
{
  mark_references(shape->table);
  return;
}

static VALUE
rb_SWFShape_s_new(self)
	 VALUE self;
{
  struct RSWFShape *s = ALLOC(struct RSWFShape);
  VALUE obj;
  
  s->this = newSWFShape();
  s->table = ALLOC(struct References);
  init_references(s->table);

  obj = Data_Wrap_Struct(rb_cSWFShape, rb_mark_SWFShape,
			  rb_free_SWFShape, s);

  return obj;
}

static VALUE
rb_SWFShape_end(self)
	 VALUE self;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_end(p->this);
  
  return self;
}


static VALUE
rb_SWFShape_hide_line(self)
	 VALUE self;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_hideLine(p->this);
  
  return self;
}


static VALUE
rb_SWFShape_move_pen_to(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_movePenTo((SWFShape) p->this, NUM2DBL(x), NUM2DBL(y));
  
  return self;
}

static VALUE
rb_SWFShape_move_pen(self, dx, dy)
	 VALUE self, dx, dy;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_movePen((SWFShape) p->this, NUM2DBL(dx), NUM2DBL(dy));
  
  return self;
}

static VALUE
rb_SWFShape_get_pen_x(self)
     VALUE self;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  return rb_float_new(SWFShape_getPenX(p->this));
}

static VALUE
rb_SWFShape_get_pen_y(self)
     VALUE self;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  return rb_float_new(SWFShape_getPenY(p->this));
}

static VALUE
rb_SWFShape_get_pen(self)
     VALUE self;
{
  struct RSWFShape *p;
  double * x = ALLOC(double), * y = ALLOC(double);
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_getPen(p->this, x, y);

  return rb_ary_new3(2, rb_float_new(*x), rb_float_new(*y));
}

static VALUE
rb_SWFShape_draw_line_to(self, x, y)
	 VALUE self, x, y;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_drawLineTo((SWFShape) p->this, NUM2DBL(x), NUM2DBL(y));
  
  return self;
}

static VALUE
rb_SWFShape_draw_line(self, dx, dy)
	 VALUE self, dx, dy;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_drawLine((SWFShape) p->this, NUM2DBL(dx), NUM2DBL(dy));
  
  return self;
}

static VALUE
rb_SWFShape_draw_curve_to(self, cdx, cdy, adx, ady)
	 VALUE self, cdx, cdy, adx, ady;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_drawCurveTo((SWFShape) p->this,
		       NUM2DBL(cdx), NUM2DBL(cdy),
		       NUM2DBL(adx), NUM2DBL(ady));
  
  return self;
}

static VALUE
rb_SWFShape_draw_curve(self, cdx, cdy, adx, ady)
	 VALUE self, cdx, cdy, adx, ady;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_drawCurve((SWFShape) p->this,
		     NUM2DBL(cdx), NUM2DBL(cdy),
		     NUM2DBL(adx), NUM2DBL(ady));
  
  return self;
}


static VALUE 
rb_SWFShape_set_line(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFShape *p;
  VALUE w, r, g, b, a;
  unsigned short width;
  byte red, green, blue, alpha;

  rb_scan_args(argc, argv, "41", &w, &r, &g, &b, &a);

  width = FIX2UINT(w);
  red   = NUM2CHR(r);
  green = NUM2CHR(g);
  blue  = NUM2CHR(b);

  if(NIL_P(a)) {
    alpha = 0xff;
  } else {
    alpha = NUM2CHR(a);
  }
  
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_setLine((SWFShape) p->this, width, red, green, blue, alpha);
  
  return self;
}

static VALUE 
rb_SWFShape_set_line_2(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFShape *p;
  VALUE w, r, g, b, a, f, m;
  unsigned short width;
  byte red, green, blue, alpha;
  int flags;
  float ml;

  rb_scan_args(argc, argv, "61", &w, &r, &g, &b, &a, &f, &m);
 
  width = FIX2UINT(w);
  red   = NUM2CHR(r);
  green = NUM2CHR(g);
  blue  = NUM2CHR(b);
  alpha = NUM2CHR(a);
  flags  = NUM2INT(f);
  ml    = NUM2DBL(m);
    
  Data_Get_Struct(self, struct RSWFShape, p);
  SWFShape_setLine2((SWFShape) p->this, width, red, green, blue, alpha, flags, ml);
  
  return self;
}


static VALUE 
rb_SWFShape_add_fill(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFFill *f = ALLOC(struct RSWFFill);
  struct RSWFShape *s;
  VALUE opt[4], obj;
  byte red, green, blue, alpha, flags;
  
  Data_Get_Struct(self, struct RSWFShape, s);
  rb_scan_args(argc, argv, "13", &opt[0], &opt[1], &opt[2], &opt[3]);

  if(rb_obj_is_kind_of(opt[0], rb_cNumeric)) {
	red   = NUM2CHR(opt[0]);
	green = NUM2CHR(opt[1]);
	blue  = NUM2CHR(opt[2]);

	if(NIL_P(opt[3])) {
	  alpha = 0xff;
	} else {
	  alpha = NUM2CHR(opt[3]);
	}

	f->this = SWFShape_addSolidFill(s->this, red, green, blue, alpha);
  } else if (rb_obj_is_kind_of(opt[0], rb_cSWFBitmap)) {
	struct RSWFBitmap *b;

	Data_Get_Struct(opt[0], struct RSWFBitmap, b);
	if(NIL_P(opt[1])) {
	  flags = 0;
	} else {
	  flags = NUM2CHR(opt[1]);
	}

	add_references(s->table, opt[0]);
	f->this = SWFShape_addBitmapFill(s->this, b->this, flags);
  } else if (rb_obj_is_kind_of(opt[0], rb_cSWFGradient)) {
	struct RSWFGradient *b;

	Data_Get_Struct(opt[0], struct RSWFGradient, b);
	if(NIL_P(opt[1])) {
	  flags = 0;
	} else {
	  flags = NUM2CHR(opt[1]);
	}
	add_references(s->table, opt[0]);
	f->this = SWFShape_addGradientFill(s->this, b->this, flags);
  } else {
	rb_raise(rb_eMingError,
		 "addFill: argument is not a bitmap nor a gradient.");
  }

  obj = Data_Wrap_Struct(rb_cSWFFill, NULL,
			 rb_free_SWFFill, f);

  return obj;
}


static VALUE
rb_SWFShape_set_left_fill(self, f)
	 VALUE self, f;
{
  struct RSWFShape *s;
  struct RSWFFill *q;
  
  Data_Get_Struct(self, struct RSWFShape, s);
  Data_Get_Struct(f, struct RSWFFill, q);

  add_references(s->table, f);
  SWFShape_setLeftFill(s->this, q->this);
  
  return self;
}

static VALUE
rb_SWFShape_set_right_fill(self, f)
	 VALUE self, f;
{
  struct RSWFShape *s;
  struct RSWFFill *q;
  
  Data_Get_Struct(self, struct RSWFShape, s);
  Data_Get_Struct(f, struct RSWFFill, q);

  add_references(s->table, f);
  SWFShape_setRightFill(s->this, q->this);
  
  return self;
}


static VALUE
rb_SWFShape_set_left_fill_style(self, f)
	 VALUE self, f;
{
  struct RSWFShape *s;
  struct RSWFFillStyle *q;
  
  Data_Get_Struct(self, struct RSWFShape, s);
  Data_Get_Struct(f, struct RSWFFillStyle, q);

  add_references(s->table, f);
  SWFShape_setLeftFillStyle(s->this, q->this);
  
  return self;
}

static VALUE
rb_SWFShape_set_right_fill_style(self, f)
	 VALUE self, f;
{
  struct RSWFShape *s;
  struct RSWFFillStyle *q;
  
  Data_Get_Struct(self, struct RSWFShape, s);
  Data_Get_Struct(f, struct RSWFFillStyle, q);

  add_references(s->table, f);
  SWFShape_setRightFillStyle(s->this, q->this);
  
  return self;
}



static VALUE
rb_SWFShape_draw_arc(self, r, sa, ea)
	 VALUE self, r, sa, ea;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);

  SWFShape_drawArc(p->this, NUM2DBL(r), NUM2DBL(sa), NUM2DBL(ea));

  return self;
}

static VALUE
rb_SWFShape_draw_circle(self, r)
	 VALUE self, r;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);

  SWFShape_drawCircle(p->this, NUM2DBL(r));

  return self;
}

static VALUE
rb_SWFShape_draw_glyph(self, font, c)
	 VALUE self, font, c;
{
  struct RSWFShape *p;
  struct RSWFFont *q;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  Data_Get_Struct(font, struct RSWFFont, q);

  add_references(p->table, font);
  SWFShape_drawGlyph(p->this, q->this, NUM2CHR(c));

  return self;
}

static VALUE
rb_SWFShape_draw_sized_glyph(self, font, c, size)
	 VALUE self, font, c, size;
{
  struct RSWFShape *p;
  struct RSWFFont *q;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  Data_Get_Struct(font, struct RSWFFont, q);

  add_references(p->table, font);
  SWFShape_drawSizedGlyph(p->this, q->this, NUM2CHR(c), NUM2INT(size));

  return self;
}

static VALUE
rb_SWFShape_draw_cubic(self, bx, by, cx, cy, dx, dy)
	 VALUE self, bx, by, cx, cy, dx, dy;
{
  struct RSWFShape *p;
  int result;
  
  Data_Get_Struct(self, struct RSWFShape, p);

  result = SWFShape_drawCubic(p->this, NUM2DBL(bx), NUM2DBL(by),
				NUM2DBL(cx), NUM2DBL(cy),
				NUM2DBL(dx), NUM2DBL(dy));

  return INT2NUM(result);
}

static VALUE
rb_SWFShape_draw_cubic_to(self, bx, by, cx, cy, dx, dy)
	 VALUE self, bx, by, cx, cy, dx, dy;
{
  struct RSWFShape *p;
  int result;
  
  Data_Get_Struct(self, struct RSWFShape, p);

  result = SWFShape_drawCubicTo(p->this, NUM2DBL(bx), NUM2DBL(by),
				NUM2DBL(cx), NUM2DBL(cy),
				NUM2DBL(dx), NUM2DBL(dy));

  return INT2NUM(result);
}

static VALUE
rb_SWFShape_draw_character_bounds(self, cer)
     VALUE self, cer;
{
  struct RSWFShape *p;
  struct RSWFCharacter *c;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  Data_Get_Struct(cer, struct RSWFCharacter, c);

  add_references(p->table, cer);
  SWFShape_drawCharacterBounds(p->this, c->this);

  return self;
}

static VALUE
rb_SWFShape_use_version(self, version)
     VALUE self, version;
{
  struct RSWFShape *s;
  
  Data_Get_Struct(self, struct RSWFShape, s);

  SWFShape_useVersion(s->this, NUM2INT(version));

  return self;
}

static VALUE
rb_SWFShape_set_render_hinting_flags(self, flags)
     VALUE self, flags;
{
  struct RSWFShape *s;
  
  Data_Get_Struct(self, struct RSWFShape, s);

  SWFShape_setRenderHintingFlags(s->this, NUM2INT(flags));

  return self;
}


static VALUE
rb_SWFShape_get_version(self)
	 VALUE self;
{
  struct RSWFShape *p;
  
  Data_Get_Struct(self, struct RSWFShape, p);
  
  
  return INT2NUM(SWFShape_getVersion(p->this));
}

void Init_swfshape()
{
  rb_cSWFShape = rb_define_class_under(rb_mMing, "SWFShape", rb_cObject);
  
  
  rb_define_const(rb_cSWFShape, "SHAPE3", 
                           INT2FIX(SWF_SHAPE3));
  rb_define_const(rb_cSWFShape, "SHAPE4", 
                           INT2FIX(SWF_SHAPE4));
  rb_define_const(rb_cSWFShape, "USE_SCALING_STROKES", 
                           INT2FIX(SWF_SHAPE_USESCALINGSTROKES));	
  rb_define_const(rb_cSWFShape, "USE_NON_SCALING_STROKES", 
                           INT2FIX(SWF_SHAPE_USENONSCALINGSTROKES));

  rb_define_singleton_method(rb_cSWFShape, "new", rb_SWFShape_s_new, 0);

  rb_define_method(rb_cSWFShape, "end",
                   rb_SWFShape_end, 0);
  rb_define_method(rb_cSWFShape, "hide_line",
                   rb_SWFShape_hide_line, 0);		   
  rb_define_method(rb_cSWFShape, "move_pen_to",
                   rb_SWFShape_move_pen_to, 2);
  rb_define_method(rb_cSWFShape, "move_pen",
                   rb_SWFShape_move_pen, 2);
  rb_define_method(rb_cSWFShape, "get_pen_x",
                   rb_SWFShape_get_pen_x, 0);
  rb_define_method(rb_cSWFShape, "get_pen_y",
                   rb_SWFShape_get_pen_y, 0);
  rb_define_method(rb_cSWFShape, "get_pen",
                   rb_SWFShape_get_pen, 0);
  rb_define_method(rb_cSWFShape, "draw_line_to",
                   rb_SWFShape_draw_line_to, 2);
  rb_define_method(rb_cSWFShape, "draw_line",
                   rb_SWFShape_draw_line, 2);
  rb_define_method(rb_cSWFShape, "draw_curve_to",
                   rb_SWFShape_draw_curve_to, 4);
  rb_define_method(rb_cSWFShape, "draw_curve",
                   rb_SWFShape_draw_curve, 4);
  rb_define_method(rb_cSWFShape, "set_line",
                   rb_SWFShape_set_line, -1);
  rb_define_method(rb_cSWFShape, "set_line_2",
                   rb_SWFShape_set_line_2, -1);
  rb_define_method(rb_cSWFShape, "add_fill",
                   rb_SWFShape_add_fill, -1);
  rb_define_method(rb_cSWFShape, "set_left_fill",
                   rb_SWFShape_set_left_fill, 1);
  rb_define_method(rb_cSWFShape, "set_right_fill",
                   rb_SWFShape_set_right_fill, 1);
  rb_define_method(rb_cSWFShape, "set_left_fill_style",
                   rb_SWFShape_set_left_fill_style, 1);
  rb_define_method(rb_cSWFShape, "set_right_fill_style",
                   rb_SWFShape_set_right_fill_style, 1);		   
  rb_define_method(rb_cSWFShape, "draw_arc",
				   rb_SWFShape_draw_arc, 3);
  rb_define_method(rb_cSWFShape, "draw_circle",
				   rb_SWFShape_draw_circle, 1);
  rb_define_method(rb_cSWFShape, "draw_glyph",
				   rb_SWFShape_draw_glyph, 2);
  rb_define_method(rb_cSWFShape, "draw_sized_glyph",
                   rb_SWFShape_draw_sized_glyph, 3);
  rb_define_alias(rb_cSWFShape, "draw_font_glyph", "draw_glyph");
  rb_define_method(rb_cSWFShape, "draw_cubic_to",
                   rb_SWFShape_draw_cubic_to, 6);
  rb_define_method(rb_cSWFShape, "draw_cubic",
                   rb_SWFShape_draw_cubic, 6);
  rb_define_method(rb_cSWFShape, "draw_character_bounds",
                   rb_SWFShape_draw_character_bounds, 1);
  rb_define_method(rb_cSWFShape, "use_version",
				   rb_SWFShape_use_version, 1);
  rb_define_method(rb_cSWFShape, "set_render_hinting_flags",
				   rb_SWFShape_set_render_hinting_flags, 1);				   
  rb_define_method(rb_cSWFShape, "get_version",
                   rb_SWFShape_get_version, 0);

  return;
}
