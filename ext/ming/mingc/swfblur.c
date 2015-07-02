/* swfblur.c     	- SWFBlur class
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

VALUE rb_cSWFBlur;

void rb_free_SWFBlur(bl)
	 struct RSWFBlur *bl;
{
  destroySWFBlur(bl->this);
  
  return;
}

static VALUE
rb_SWFBlur_new(self, blurX, blurY, passes)
	 VALUE self, blurX, blurY, passes;
{
  struct RSWFBlur *bl = ALLOC(struct RSWFBlur);
  VALUE obj;

  bl->this = newSWFBlur(NUM2DBL(blurX), NUM2DBL(blurY), NUM2INT(passes));
  if (bl->this == NULL)
    rb_raise(rb_eMingError, "Bad arguments given, need 3 arguments - %s", NULL);
  bl->table = ALLOC(struct References);
  init_references(bl->table);

  obj = Data_Wrap_Struct(rb_cSWFBlur, NULL,
			 rb_free_SWFBlur, bl);

  return obj;
}

void Init_swfblur()
{
  rb_cSWFBlur = rb_define_class_under(rb_mMing, "SWFBlur", 
                                           rb_cObject);
  
  rb_define_singleton_method(rb_cSWFBlur, "new", rb_SWFBlur_new, 3);
  
 
  return;
}

