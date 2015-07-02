/* swfmorph.c	- SWFMorph class
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

VALUE rb_cSWFMorph;

void rb_free_SWFMorph(p)
     struct RSWFMorph *p;
{
  destroySWFMorph(p->this);

  return;
}

static VALUE
rb_SWFMorph_s_new(self)
	 VALUE self;
{
  struct RSWFMorph *m = ALLOC(struct RSWFMorph);
  VALUE obj;

  m->this = newSWFMorphShape();
  
  obj = Data_Wrap_Struct(rb_cSWFMorph, 0,
			  rb_free_SWFMorph, m);

  return obj;
}

static VALUE
rb_SWFMorph_get_shape1(self)
	 VALUE self;
{
  struct RSWFMorph *m;
  struct RSWFShape *s = ALLOC(struct RSWFShape);
  VALUE obj;
  
  Data_Get_Struct(self, struct RSWFMorph, m);
  s->this = SWFMorph_getShape1(m->this);
  s->table = ALLOC(struct References);
  init_references(s->table);
	
  obj = Data_Wrap_Struct(rb_cSWFShape, 0,
			 rb_free_SWFShape, s);

  return obj;
}

static VALUE
rb_SWFMorph_get_shape2(self)
     VALUE self;
{
  struct RSWFMorph *m;
  struct RSWFShape *s = ALLOC(struct RSWFShape);
  VALUE obj;
  
  Data_Get_Struct(self, struct RSWFMorph, m);
  s->this = SWFMorph_getShape2(m->this);
  s->table = ALLOC(struct References);
  init_references(s->table);
	
  obj = Data_Wrap_Struct(rb_cSWFShape, 0,
			  rb_free_SWFShape, s);

  return obj;
}

void
Init_swfmorph()
{
  rb_cSWFMorph = rb_define_class_under(rb_mMing, "SWFMorph", rb_cObject);

  rb_define_singleton_method(rb_cSWFMorph, "new", rb_SWFMorph_s_new, 0);

  rb_define_method(rb_cSWFMorph, "get_shape1",
				   rb_SWFMorph_get_shape1, 0);
  rb_define_method(rb_cSWFMorph, "get_shape2",
				   rb_SWFMorph_get_shape2, 0);

  return;
}
