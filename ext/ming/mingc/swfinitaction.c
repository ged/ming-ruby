/* swfaction.c	- SWFAction class
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

VALUE rb_cSWFInitAction;

void
rb_free_SWFInitAction(ia)
	struct RSWFInitAction *ia;
{
   //destroySWFInitAction((SWFInitAction)ia->this);

   return;  
}

static VALUE
rb_SWFInitAction_new(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFAction *a;
  struct RSWFInitAction *ia = ALLOC(struct RSWFInitAction);
  VALUE opt[2], obj;
  ia->table = ALLOC(struct References);
  init_references(ia->table); 
  rb_scan_args(argc, argv, "11", &opt[0], &opt[1]);
  Data_Get_Struct(opt[0], struct RSWFAction, a);
  
  if(NIL_P(opt[1])) {
  ia->this = newSWFInitAction(a->this);
  } else {
  ia->this = newSWFInitAction_withId(a->this, NUM2INT(opt[1]));
  }
 
  add_references(ia->table, opt[0]);

  obj = Data_Wrap_Struct(rb_cSWFInitAction, NULL,
			 rb_free_SWFInitAction, ia);

  return obj;
}


void Init_swfinitaction()
{
  rb_cSWFInitAction = rb_define_class_under(rb_mMing, "SWFInitAction", rb_cObject);

  rb_define_singleton_method(rb_cSWFInitAction, "new",
                   rb_SWFInitAction_new, -1);
  
  return;
}
