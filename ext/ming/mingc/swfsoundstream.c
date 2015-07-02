/* swfsoundstream.c	- SoundStream class
 * $Id$
 *
 * Copyright (C) 2007 Karwowski Pawel <pkarwow at fastmail dot fm>
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

VALUE rb_cSWFSoundStream;

void
rb_free_SWFSoundStream(p)
	 struct RSWFSoundStream *p;
{
  destroySWFSoundStream(p->this);
  
  return;  
}


void rb_SWFSoundStream_mark(sound)
     struct RSWFSoundStream *sound;
{
  mark_references(sound->table);
  return;
}


static VALUE
rb_SWFSoundStream_new_from_input(self, sound)
     VALUE self, sound;
{
  struct RSWFSoundStream *p = ALLOC(struct RSWFSoundStream);
  FILE *fp;
  VALUE obj;

  fp = fopen(StringValuePtr(sound), "rb");
  p->this = newSWFSoundStream_fromInput(newSWFInput_file(fp));
  p->table = ALLOC(struct References);
  init_references(p->table);
  p->option = fp;
  obj = Data_Wrap_Struct(rb_cSWFSoundStream, rb_SWFSoundStream_mark,
                         rb_free_SWFSoundStream, p);

  return obj;
}

static VALUE
rb_SWFSoundStream_get_frames(self)
	 VALUE self;
{
  struct RSWFSoundStream *s;
  
  Data_Get_Struct(self, struct RSWFSoundStream, s);

  return INT2NUM(SWFSoundStream_getFrames(s->this));
}

static VALUE
rb_SWFSoundStream_get_duration(self)
	 VALUE self;
{
  struct RSWFSoundStream *s;
  
  Data_Get_Struct(self, struct RSWFSoundStream, s);

  return UINT2NUM(SWFSoundStream_getDuration(s->this));
}


void Init_swfsoundstream()
{
  rb_cSWFSoundStream = rb_define_class_under(rb_mMing, "SWFSoundStream", rb_cObject);


  rb_define_singleton_method(rb_cSWFSoundStream, "new", rb_SWFSoundStream_new_from_input, 1);
  rb_define_method(rb_cSWFSoundStream, "get_frames", rb_SWFSoundStream_get_frames, 0);	
  rb_define_method(rb_cSWFSoundStream, "get_duration", rb_SWFSoundStream_get_duration, 0);	  
 

  return;
}
