 /* swfsound.c	- SWFSound class
  * Copyright (C) 2007 Karwowski Pawel <pkarwow at fastmail dot fm>
  * All rights reserved.  *
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
 
VALUE rb_cSWFSound;
 
void
rb_free_SWFSound(p)
	struct RSWFSound *p;
{
   destroySWFSound(p->this);

   return;  
}
 
void
rb_mark_SWFSound(sound)
	struct RSWFSound *sound;
{
   mark_references(sound->table);
   return;
}
 
static VALUE 
rb_SWFSound_s_new(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFSound *s = ALLOC(struct RSWFSound);
  struct RSWFSoundStream *ss;
  VALUE arg1, arg2, obj;
  FILE *fp;
  
  rb_scan_args(argc, argv, "11", &arg1, &arg2);
 
  if(rb_obj_is_kind_of(arg1, rb_cSWFSoundStream)) {
   
    Data_Get_Struct(arg1, struct RSWFSoundStream, ss);
	s->this = newSWFSound_fromSoundStream(ss->this);
	
  } else {

    fp = fopen(StringValuePtr(arg1), "rb");
    s->this = newSWFSound_fromInput(newSWFInput_file(fp), NUM2CHR(arg2));
 
  }
  s->table = ALLOC(struct References);
  init_references(s->table);
  s->option = fp;
  
  obj = Data_Wrap_Struct(rb_cSWFSound, rb_mark_SWFSound,
			 rb_free_SWFSound, s);

  return obj;
}

 
void Init_swfsound()
 {
   rb_cSWFSound = rb_define_class_under(rb_mMing, "SWFSound", rb_cObject);
 
   rb_define_const(rb_cSWFSound, "COMPRESSION",
		   INT2FIX(SWF_SOUND_COMPRESSION));
   rb_define_const(rb_cSWFSound, "NOT_COMPRESSED", 
                   INT2FIX(SWF_SOUND_NOT_COMPRESSED));
   rb_define_const(rb_cSWFSound, "ADPCM_COMPRESSED",
                   INT2FIX(SWF_SOUND_ADPCM_COMPRESSED));
   rb_define_const(rb_cSWFSound, "MP3_COMPRESSED",
                   INT2FIX(SWF_SOUND_MP3_COMPRESSED));
   rb_define_const(rb_cSWFSound, "NOT_COMPRESSED_LE", 
                   INT2FIX(SWF_SOUND_NOT_COMPRESSED_LE));
   rb_define_const(rb_cSWFSound, "NELLY_COMPRESSED",
                   INT2FIX(SWF_SOUND_NELLY_COMPRESSED));		  		  		  
   rb_define_const(rb_cSWFSound, "RATE",
                   INT2FIX(SWF_SOUND_RATE));
   rb_define_const(rb_cSWFSound, "KHZ_5",
                   INT2FIX(SWF_SOUND_5KHZ));		   
   rb_define_const(rb_cSWFSound, "KHZ_11",
                   INT2FIX(SWF_SOUND_11KHZ));
   rb_define_const(rb_cSWFSound, "KHZ_22",
                   INT2FIX(SWF_SOUND_22KHZ));
   rb_define_const(rb_cSWFSound, "KHZ_44",
                   INT2FIX(SWF_SOUND_44KHZ));
   rb_define_const(rb_cSWFSound, "BITS",
                   INT2FIX(SWF_SOUND_BITS));
   rb_define_const(rb_cSWFSound, "BITS_8",
                   INT2FIX(SWF_SOUND_8BITS));		   
   rb_define_const(rb_cSWFSound, "BITS_16",
                   INT2FIX(SWF_SOUND_16BITS));
   rb_define_const(rb_cSWFSound, "CHANNELS",
                   INT2FIX(SWF_SOUND_CHANNELS));
   rb_define_const(rb_cSWFSound, "MONO",
                   INT2FIX(SWF_SOUND_MONO));		   
   rb_define_const(rb_cSWFSound, "STEREO",
                   INT2FIX(SWF_SOUND_STEREO));
 
 
   rb_define_singleton_method(rb_cSWFSound, "new", rb_SWFSound_s_new, -1);
   return;
 }
 
