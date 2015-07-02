/* swfsoundinstance.c	- SoundInstance class
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

VALUE rb_cSWFSoundInstance;

static VALUE
rb_SWFSoundInstance_set_no_multiple(self)
     VALUE self;
{
  struct RSWFSoundInstance *s;
  
  Data_Get_Struct(self, struct RSWFSoundInstance, s);
  SWFSoundInstance_setNoMultiple(s->this);

  return self;
}

static VALUE
rb_SWFSoundInstance_set_loop_in_point(self, point)
     VALUE self, point;
{
  struct RSWFSoundInstance *s;
  
  Data_Get_Struct(self, struct RSWFSoundInstance, s);

  if (NUM2INT(point) < 0)
    return Qnil;

  SWFSoundInstance_setLoopInPoint(s->this, NUM2UINT(point));

  return self;
}

static VALUE
rb_SWFSoundInstance_set_loop_out_point(self, point)
     VALUE self, point;
{
  struct RSWFSoundInstance *s;
  
  Data_Get_Struct(self, struct RSWFSoundInstance, s);

  if (NUM2INT(point) < 0)
    return Qnil;

  SWFSoundInstance_setLoopOutPoint(s->this, NUM2UINT(point));

  return self;
}

static VALUE
rb_SWFSoundInstance_set_loop_count(self, count)
     VALUE self, count;
{
  struct RSWFSoundInstance *s;
  
  Data_Get_Struct(self, struct RSWFSoundInstance, s);

  SWFSoundInstance_setLoopCount(s->this, NUM2INT(count));

  return self;
}

static VALUE
rb_SWFSoundInstance_add_envelope(self, mark44, left, right)
     VALUE self, mark44, left, right;
{
  struct RSWFSoundInstance *s;
  
  Data_Get_Struct(self, struct RSWFSoundInstance, s);

  if (NUM2INT(mark44) < 0)
    return Qnil;

  SWFSoundInstance_addEnvelope(s->this, NUM2UINT(mark44), FIX2INT(left), FIX2INT(right));

  return self;
}


void Init_swfsoundinstance()
{
  rb_cSWFSoundInstance = rb_define_class_under(rb_mMing, "SWFSoundInstance", rb_cObject);

  rb_define_method(rb_cSWFSoundInstance, "set_no_multiple",
                   rb_SWFSoundInstance_set_no_multiple, 0);
  rb_define_method(rb_cSWFSoundInstance, "set_loop_in_point",
                   rb_SWFSoundInstance_set_loop_in_point, 1);
  rb_define_method(rb_cSWFSoundInstance, "set_loop_out_point",
                   rb_SWFSoundInstance_set_loop_out_point, 1);
  rb_define_method(rb_cSWFSoundInstance, "set_loop_count",
                   rb_SWFSoundInstance_set_loop_count, 1);
  rb_define_method(rb_cSWFSoundInstance, "add_envelope",
                   rb_SWFSoundInstance_add_envelope, 3);		   

  return;
}
