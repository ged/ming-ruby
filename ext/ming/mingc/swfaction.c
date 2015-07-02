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

VALUE rb_cSWFAction;

void
rb_free_SWFAction(p)
	 struct RSWFAction *p;
{
  //destroySWFAction(p->this);
  
  return;  
}

static VALUE
rb_SWFAction_s_new(self, s)
	 VALUE self, s;
{
  char *script = StringValuePtr(s);
  struct RSWFAction *a = ALLOC(struct RSWFAction);
  VALUE obj;

  a->this = newSWFAction(script);
  if (a->this == NULL)
    rb_raise(rb_eMingError, "Could not compile actionscripts - %s", script);
  a->table = ALLOC(struct References);
  init_references(a->table);

  obj = Data_Wrap_Struct(rb_cSWFAction, 0,
			 rb_free_SWFAction, a);

  return obj;
}

static VALUE
rb_SWFAction_set_debug(self, debug)
         VALUE self, debug;
{
  struct RSWFAction *action;

  Data_Get_Struct(self, struct RSWFAction, action);

  return INT2NUM(SWFAction_setDebug(action->this, 1));

}

void Init_swfaction()
{
  rb_cSWFAction = rb_define_class_under(rb_mMing, "SWFAction", rb_cObject);
  
  
  rb_define_const(rb_cSWFAction, "ON_LOAD",
                  INT2FIX(SWFACTION_ONLOAD));
  rb_define_const(rb_cSWFAction, "ENTER_FRAME",
                  INT2FIX(SWFACTION_ENTERFRAME));
  rb_define_const(rb_cSWFAction, "UN_LOAD",
                  INT2FIX(SWFACTION_UNLOAD));
  rb_define_const(rb_cSWFAction, "MOUSE_MOVE",
                  INT2FIX(SWFACTION_MOUSEMOVE));
  rb_define_const(rb_cSWFAction, "MOUSE_UP",
                  INT2FIX(SWFACTION_MOUSEUP));
  rb_define_const(rb_cSWFAction, "MOUSE_DOWN",
                  INT2FIX(SWFACTION_MOUSEDOWN));
  rb_define_const(rb_cSWFAction, "KEY_UP",
                  INT2FIX(SWFACTION_KEYUP));
  rb_define_const(rb_cSWFAction, "KEY_DOWN",
                  INT2FIX(SWFACTION_KEYDOWN));
  rb_define_const(rb_cSWFAction, "DATA",
                  INT2FIX(SWFACTION_DATA));
  rb_define_const(rb_cSWFAction, "INIT",
                  INT2FIX(SWFACTION_INIT));
  rb_define_const(rb_cSWFAction, "PRESS",
                  INT2FIX(SWFACTION_PRESS));		  
  rb_define_const(rb_cSWFAction, "RELEASE",
                  INT2FIX(SWFACTION_RELEASE));
  rb_define_const(rb_cSWFAction, "RELEASE_OUTSIDE",
                  INT2FIX(SWFACTION_RELEASEOUTSIDE));		  
  rb_define_const(rb_cSWFAction, "ROLL_OVER",
                  INT2FIX(SWFACTION_ROLLOVER));
  rb_define_const(rb_cSWFAction, "ROLL_OUT",
                  INT2FIX(SWFACTION_ROLLOUT));		  
  rb_define_const(rb_cSWFAction, "DRAG_OVER",
                  INT2FIX(SWFACTION_DRAGOVER));
  rb_define_const(rb_cSWFAction, "DRAG_OUT",
                  INT2FIX(SWFACTION_DRAGOUT));
  rb_define_const(rb_cSWFAction, "KEY_PRESS",
                  INT2FIX(SWFACTION_KEYPRESS));		  
  rb_define_const(rb_cSWFAction, "CONSTRUCT",
                  INT2FIX(SWFACTION_CONSTRUCT));

  rb_define_singleton_method(rb_cSWFAction, "new",
			     rb_SWFAction_s_new, 1);

  rb_define_method(rb_cSWFAction, "set_debug", rb_SWFAction_set_debug, 0); 				 
				 
  return;
}
