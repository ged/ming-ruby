/* swffilter     	- SWFFilter class
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

VALUE rb_cSWFFilter;

void rb_free_SWFFilter(f)
	 struct RSWFFilter *f;
{
  destroySWFFilter(f->this);
  
  return;
}

static void rb_mark_SWFFilter(f)
     struct RSWFFilter *f;
{
  mark_references(f->table);
  return;
}

static VALUE
rb_SWFFilter_new_blur_filter(self, blur)
	 VALUE self, blur;
{
  struct RSWFBlur *bl;
  struct RSWFFilter *f = ALLOC(struct RSWFFilter);
  VALUE obj;

  Data_Get_Struct(blur, struct RSWFBlur, bl);
  
  f->this = newBlurFilter(bl->this);
  f->table = ALLOC(struct References);
  init_references(f->table);
  add_references(f->table, blur);

  obj = Data_Wrap_Struct(rb_cSWFFilter, rb_mark_SWFFilter,
			 rb_free_SWFFilter, f);

  return obj;
}

static VALUE
rb_SWFFilter_new_gradient_glow_filter(self, gradient, blur, shadow, flags)
	 VALUE self, gradient, blur, shadow, flags;
{
  struct RSWFGradient *gr;
  struct RSWFBlur *bl;
  struct RSWFShadow *sh;
  struct RSWFFilter *f = ALLOC(struct RSWFFilter);
  VALUE obj;

  Data_Get_Struct(gradient, struct RSWFGradient, gr);
  Data_Get_Struct(blur, struct RSWFBlur, bl);
  Data_Get_Struct(shadow, struct RSWFShadow, sh);
  
  f->this = newGradientGlowFilter(gr->this, bl->this, sh->this, NUM2INT(flags));
  f->table = ALLOC(struct References);
  init_references(f->table);
  add_references(f->table, gradient);
  add_references(f->table, blur);
  add_references(f->table, shadow);

  obj = Data_Wrap_Struct(rb_cSWFFilter, rb_mark_SWFFilter,
			 rb_free_SWFFilter, f);

  return obj;
}

static VALUE
rb_SWFFilter_new_gradient_bevel_filter(self, gradient, blur, shadow, flags)
	 VALUE self, gradient, blur, shadow, flags;
{
  struct RSWFGradient *gr;
  struct RSWFBlur *bl;
  struct RSWFShadow *sh;
  struct RSWFFilter *f = ALLOC(struct RSWFFilter);
  VALUE obj;

  Data_Get_Struct(gradient, struct RSWFGradient, gr);
  Data_Get_Struct(blur, struct RSWFBlur, bl);
  Data_Get_Struct(shadow, struct RSWFShadow, sh);
  
  f->this = newGradientBevelFilter(gr->this, bl->this, sh->this, NUM2INT(flags));
  f->table = ALLOC(struct References);
  init_references(f->table);
  add_references(f->table, gradient);
  add_references(f->table, blur);
  add_references(f->table, shadow);

  obj = Data_Wrap_Struct(rb_cSWFFilter, rb_mark_SWFFilter,
			 rb_free_SWFFilter, f);

  return obj;
}

static VALUE
rb_SWFFilter_new_drop_shadow_filter(self, color, blur, shadow, flags)
	 VALUE self, color, blur, shadow, flags;
{
  struct RSWFColor *cl;
  struct RSWFBlur *bl;
  struct RSWFShadow *sh;
  struct RSWFFilter *f = ALLOC(struct RSWFFilter);
  VALUE obj;

  Data_Get_Struct(color, struct RSWFColor, cl);
  Data_Get_Struct(blur, struct RSWFBlur, bl);
  Data_Get_Struct(shadow, struct RSWFShadow, sh);
  
  f->this = newDropShadowFilter(cl->this, bl->this, sh->this, NUM2INT(flags));
  f->table = ALLOC(struct References);
  init_references(f->table);
  add_references(f->table, color);
  add_references(f->table, blur);
  add_references(f->table, shadow);

  obj = Data_Wrap_Struct(rb_cSWFFilter, rb_mark_SWFFilter,
			 rb_free_SWFFilter, f);

  return obj;
}

static VALUE
rb_SWFFilter_new_glow_filter(self, color, blur, strenght, flags)
	 VALUE self, color, blur, strenght, flags;
{
  struct RSWFColor *cl;
  struct RSWFBlur *bl;
  struct RSWFFilter *f = ALLOC(struct RSWFFilter);
  VALUE obj;

  Data_Get_Struct(color, struct RSWFColor, cl);
  Data_Get_Struct(blur, struct RSWFBlur, bl);
  
  f->this = newGlowFilter(cl->this, bl->this, NUM2DBL(strenght), NUM2INT(flags));
  f->table = ALLOC(struct References);
  init_references(f->table);
  add_references(f->table, color);
  add_references(f->table, blur);

  obj = Data_Wrap_Struct(rb_cSWFFilter, rb_mark_SWFFilter,
			 rb_free_SWFFilter, f);

  return obj;
}

static VALUE
rb_SWFFilter_new_bevel_filter(self, shadowcolor, highlightcolor, blur, shadow, flags)
	 VALUE self, shadowcolor, highlightcolor, blur, shadow, flags;
{
  struct RSWFColor *cl;
  struct RSWFColor *cl1;
  struct RSWFBlur *bl;
  struct RSWFShadow *sh;
  struct RSWFFilter *f = ALLOC(struct RSWFFilter);
  VALUE obj;

  Data_Get_Struct(shadowcolor, struct RSWFColor, cl);
  Data_Get_Struct(highlightcolor, struct RSWFColor, cl1);
  Data_Get_Struct(blur, struct RSWFBlur, bl);
  Data_Get_Struct(shadow, struct RSWFShadow, sh);
  
  f->this = newBevelFilter(cl->this, cl1->this, bl->this, sh->this, NUM2INT(flags));
  f->table = ALLOC(struct References);
  init_references(f->table);
  add_references(f->table, shadowcolor);
  add_references(f->table, highlightcolor);
  add_references(f->table, blur);
  add_references(f->table, shadow);

  obj = Data_Wrap_Struct(rb_cSWFFilter, rb_mark_SWFFilter,
			 rb_free_SWFFilter, f);

  return obj;
}

static VALUE
rb_SWFFilter_new_color_matrix_filter(self, cmf)
	 VALUE self, cmf;
{
  struct RSWFFilterMatrix *fm;
  struct RSWFFilter *f = ALLOC(struct RSWFFilter);
  VALUE obj;

  Data_Get_Struct(cmf, struct RSWFFilterMatrix, fm);
  
  f->this = newColorMatrixFilter(fm->this);
  f->table = ALLOC(struct References);
  init_references(f->table);
  add_references(f->table, cmf);

  obj = Data_Wrap_Struct(rb_cSWFFilter, rb_mark_SWFFilter,
			 rb_free_SWFFilter, f);

  return obj;
}


static VALUE
rb_SWFFilter_new_convolution_filter(self, matrix, divisor, bias, color, flags)
	 VALUE self, matrix, divisor, bias, color, flags;
{
  struct RSWFFilterMatrix *fm;
  struct RSWFColor *cl;
  struct RSWFFilter *f = ALLOC(struct RSWFFilter);
  VALUE obj;

  Data_Get_Struct(matrix, struct RSWFFilterMatrix, fm);
  Data_Get_Struct(color, struct RSWFColor, cl);

  
  f->this = newConvolutionFilter(fm->this, NUM2DBL(divisor), NUM2DBL(bias),cl->this, NUM2INT(flags));
  f->table = ALLOC(struct References);
  init_references(f->table);
  add_references(f->table, matrix);
  add_references(f->table, color);

  obj = Data_Wrap_Struct(rb_cSWFFilter, rb_mark_SWFFilter,
			 rb_free_SWFFilter, f);

  return obj;
}


void Init_swffilter()
{
  
  rb_cSWFFilter = rb_define_class_under(rb_mMing, "SWFFilter", 
                                           rb_cObject);
										   
  rb_define_const(rb_cSWFFilter, "MODE_INNER",
                  INT2FIX(FILTER_MODE_INNER));
  rb_define_const(rb_cSWFFilter, "MODE_KO",
                  INT2FIX(FILTER_MODE_KO));				 
  rb_define_const(rb_cSWFFilter, "MODE_COMPOSITE",
                  INT2FIX(FILTER_MODE_COMPOSITE));		
  rb_define_const(rb_cSWFFilter, "MODE_ONTOP",
                  INT2FIX(FILTER_MODE_ONTOP));			
  rb_define_const(rb_cSWFFilter, "FLAG_CLAMP",
                  INT2FIX(FILTER_FLAG_CLAMP));					  
  rb_define_const(rb_cSWFFilter, "FLAG_PRESERVE_ALPHA",
                  INT2FIX(FILTER_FLAG_PRESERVE_ALPHA));				  
										   
  rb_define_singleton_method(rb_cSWFFilter, "set_blur_filter",
                   rb_SWFFilter_new_blur_filter, 1);
  rb_define_singleton_method(rb_cSWFFilter, "set_gradient_glow_filter",
		   rb_SWFFilter_new_gradient_glow_filter, 4);					
  rb_define_singleton_method(rb_cSWFFilter, "set_gradient_bevel_filter",
		   rb_SWFFilter_new_gradient_bevel_filter, 4);			   
  rb_define_singleton_method(rb_cSWFFilter, "set_drop_shadow_filter",
		   rb_SWFFilter_new_drop_shadow_filter, 4);			   
  rb_define_singleton_method(rb_cSWFFilter, "set_glow_filter",
		   rb_SWFFilter_new_glow_filter, 4);	
  rb_define_singleton_method(rb_cSWFFilter, "set_bevel_filter",
		   rb_SWFFilter_new_bevel_filter, 5);	
  rb_define_singleton_method(rb_cSWFFilter, "set_color_matrix_filter",
                   rb_SWFFilter_new_color_matrix_filter, 1);
  rb_define_singleton_method(rb_cSWFFilter, "set_convolution_filter",
		   rb_SWFFilter_new_convolution_filter, 5);			   		   
  
  
  return;
}

