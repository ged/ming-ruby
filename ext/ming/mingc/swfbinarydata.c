/* swfbinarydata.c	- SWFBinaryData class
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

VALUE rb_cSWFBinaryData;

void
rb_free_SWFBinaryData(data)
	struct RSWFBinaryData *data;
{
   destroySWFBinaryData(data->this);

   return;  
}

static VALUE
rb_SWFBinaryData_new(self, binarydata, length)
	 VALUE self, binarydata, length;
{
  struct RSWFBinaryData *d = ALLOC(struct RSWFBinaryData);
  VALUE obj;

  d->this  = newSWFBinaryData((unsigned char *)(binarydata), NUM2INT(length));
  d->table = ALLOC(struct References);
  init_references(d->table);
  obj = Data_Wrap_Struct(rb_cSWFBinaryData, 0,
			 rb_free_SWFBinaryData, d);

  return obj;
}

void Init_swfbinarydata()
{
  rb_cSWFBinaryData = rb_define_class_under(rb_mMing, "SWFBinaryData", rb_cObject);
  rb_define_singleton_method(rb_cSWFBinaryData, "new", 
                             rb_SWFBinaryData_new, 2);
  return;
}
