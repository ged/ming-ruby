/* swfshadow.c  	- SWFShadow class
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

VALUE rb_cSWFShadow;

void rb_free_SWFShadow(sh)
	 struct RSWFShadow *sh;
{
  destroySWFShadow(sh->this);
  
  return;
}

static VALUE
rb_SWFShadow_new(self, angle, distance, strenght)
	 VALUE self, angle, distance, strenght;
{
  struct RSWFShadow *sh = ALLOC(struct RSWFShadow);
  VALUE obj;

  sh->this = newSWFShadow(NUM2DBL(angle), NUM2DBL(distance), NUM2DBL(strenght));
  if (sh->this == NULL)
    rb_raise(rb_eMingError, "Bad arguments given, need 3 arguments - %s", NULL);
  sh->table = ALLOC(struct References);
  init_references(sh->table);

  obj = Data_Wrap_Struct(rb_cSWFShadow, NULL,
			 rb_free_SWFShadow, sh);

  return obj;
}

void Init_swfshadow()
{
  rb_cSWFShadow = rb_define_class_under(rb_mMing, "SWFShadow", 
                                           rb_cObject);
  
  rb_define_singleton_method(rb_cSWFShadow, "new", rb_SWFShadow_new, 3);
  
 
  return;
}

