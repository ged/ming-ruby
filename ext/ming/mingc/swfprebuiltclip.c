/* swfprebuiltclip.c	- SWFPrebuiltClip class
 * $Id$
 *
 * Copyright (C) 2006 Karwowski Pawel <pkarwow at fastmail dot fm>
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

VALUE rb_cSWFPrebuiltClip;

void
rb_free_SWFPrebuiltClip(p)
	 struct RSWFPrebuiltClip *p;
{
  destroySWFPrebuiltClip(p->this);

  return;  
}

static VALUE
rb_SWFPrebuiltClip_s_new_from_input(self, clip)
     VALUE self, clip;
{
  struct RSWFPrebuiltClip *p = ALLOC(struct RSWFPrebuiltClip);
  FILE *fp;
  VALUE obj;

  fp = fopen(StringValuePtr(clip), "rb");
  p->this = newSWFPrebuiltClip_fromInput(newSWFInput_file(fp));
  p->table = ALLOC(struct References);
  init_references(p->table);
  p->option = fp;
  obj = Data_Wrap_Struct(rb_cSWFPrebuiltClip, 0,
                         rb_free_SWFPrebuiltClip, p);

  return obj;
}

void Init_swfprebuiltclip()
{
  rb_cSWFPrebuiltClip = rb_define_class_under(rb_mMing, "SWFPrebuiltClip", rb_cObject);
  rb_define_singleton_method(rb_cSWFPrebuiltClip, "new", rb_SWFPrebuiltClip_s_new_from_input, 1);
  return;
}

