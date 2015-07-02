/* swfmovieclip.c	- SWFMovieClip class
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

VALUE rb_cSWFMovieClip;

void rb_free_SWFMovieClip(p)
	 struct RSWFMovieClip *p;
{
  destroySWFMovieClip(p->this);
  
  return;  
}

void rb_mark_SWFMovieClip(clip)
     struct RSWFMovieClip *clip;
{
  mark_references(clip->table);
  return;
}

static VALUE
rb_SWFMovieClip_s_new(self)
	 VALUE self;
{
  struct RSWFMovieClip *s = ALLOC(struct RSWFMovieClip);
  VALUE obj;

  s->this = newSWFMovieClip();
  s->table = ALLOC(struct References);
  init_references(s->table);
  
  obj = Data_Wrap_Struct(rb_cSWFMovieClip, rb_mark_SWFMovieClip,
			  rb_free_SWFMovieClip, s);

  return obj;
}

static VALUE
rb_SWFMovieClip_set_frames(self, t)
	 VALUE self, t;
{
  struct RSWFMovieClip *m;

  Data_Get_Struct(self, struct RSWFMovieClip, m);

  SWFMovieClip_setNumberOfFrames(m->this, NUM2INT(t));

  return self;
}

static VALUE
rb_SWFMovieClip_next_frame(self)
	 VALUE self;
{
  struct RSWFMovieClip *p;

  Data_Get_Struct(self, struct RSWFMovieClip, p);

  SWFMovieClip_nextFrame(p->this);

  return self;
}

static VALUE
rb_SWFMovieClip_label_frame(self, s)
	 VALUE self, s;
{
  struct RSWFMovieClip *m;

  Data_Get_Struct(self, struct RSWFMovieClip, m);

  SWFMovieClip_labelFrame(m->this, StringValuePtr(s));

  return self;
}

static VALUE
rb_SWFMovieClip_add(self, c)
	 VALUE self, c;
{
  struct RSWFMovieClip *s;
  struct RSWFBlock *b;
  struct RSWFDisplayItem *i;
  SWFDisplayItem item;
  VALUE obj;

  Data_Get_Struct(self, struct RSWFMovieClip, s);
  Data_Get_Struct(c, struct RSWFBlock, b);

  add_references(s->table, c);
  item = SWFMovieClip_add(s->this, b->this);

  if (item == NULL)
    obj = Qnil;
  else {
    i = ALLOC(struct RSWFDisplayItem);
    i->this = item;
    obj =  Data_Wrap_Struct(rb_cSWFDisplayItem, NULL,
				    -1, i);
    add_references(s->table, obj);
  }

  return obj;
}

static VALUE
rb_SWFMovieClip_remove(self, item)
	 VALUE self, item;
{
  struct RSWFMovieClip *m;
  struct RSWFDisplayItem *i;

  Data_Get_Struct(self, struct RSWFMovieClip, m);
  Data_Get_Struct(item, struct RSWFDisplayItem, i);

  SWFMovieClip_remove(m->this, i->this);

  return self;
}

static VALUE
rb_SWFMovieClip_set_sound_stream(self, sound, rate)
     VALUE self, sound, rate;
{
  struct RSWFMovieClip *m;
  struct RSWFSoundStream *s;

  Data_Get_Struct(self, struct RSWFMovieClip, m);
  Data_Get_Struct(sound, struct RSWFSoundStream, s);

  SWFMovieClip_setSoundStream(m->this, s->this, NUM2DBL(rate));

  return self;
}

static VALUE
rb_SWFMovieClip_set_sound_stream_at(self, sound, rate, skip)
     VALUE self, sound, rate, skip;
{
  struct RSWFMovieClip *m;
  struct RSWFSoundStream *s;

  Data_Get_Struct(self, struct RSWFMovieClip, m);
  Data_Get_Struct(sound, struct RSWFSoundStream, s);

  SWFMovieClip_setSoundStreamAt(m->this, s->this, NUM2DBL(rate), NUM2DBL(skip));

  return self;
}

static VALUE
rb_SWFMovieClip_start_sound(self, sound)
     VALUE self, sound;
{
  struct RSWFMovieClip *m;
  struct RSWFSound *s;
  struct RSWFSoundInstance *si = ALLOC(struct RSWFSoundInstance);
  VALUE obj;

  Data_Get_Struct(self, struct RSWFMovieClip, m);
  Data_Get_Struct(sound, struct RSWFSound, s);

  si->this = SWFMovieClip_startSound(m->this, s->this);
  si->table = ALLOC(struct References);
  init_references(si->table);

  add_references(m->table, self);
  add_references(m->table, sound);
  
  obj = Data_Wrap_Struct(rb_cSWFSoundInstance, NULL, 
                         NULL, si);
						 
  add_references(m->table, obj);
  
  return obj;
}

static VALUE
rb_SWFMovieClip_stop_sound(self, sound)
     VALUE self, sound;
{
  struct RSWFMovieClip *m;
  struct RSWFSound *s;

  Data_Get_Struct(self, struct RSWFMovieClip, m);
  Data_Get_Struct(sound, struct RSWFSound, s);

  SWFMovieClip_stopSound(m->this, s->this);

  return self;
}

static VALUE
rb_SWFMovieClip_set_scaling_grid(self, dx, dy, dw, dh)
	 VALUE self, dx, dy, dw, dh;
{
  struct RSWFMovieClip *m;
  
  Data_Get_Struct(self, struct RSWFMovieClip, m);
  SWFMovieClip_setScalingGrid((SWFMovieClip) m->this,
		     NUM2INT(dx), NUM2INT(dy),
		     NUM2INT(dw), NUM2INT(dh));
  
  return self;
}

static VALUE
rb_SWFMovieClip_remove_scaling_grid(self)
         VALUE self;
{
   struct RSWFMovieClip *m;

   Data_Get_Struct(self, struct RSWFMovieClip, m);
   SWFMovieClip_removeScalingGrid(m->this);

   return self;
}


static VALUE
rb_SWFMovieClip_add_init_action(self, action)
     VALUE self, action;
{
  struct RSWFMovieClip *m;
  struct RSWFAction *a;

  Data_Get_Struct(self, struct RSWFMovieClip, m);
  Data_Get_Struct(action, struct RSWFAction, a);

  SWFMovieClip_addInitAction(m->this, a->this);

  return self;
}


void Init_swfmovieclip()
{
  rb_cSWFMovieClip = rb_define_class_under(rb_mMing, "SWFMovieClip",
					   rb_cObject);
  rb_define_singleton_method(rb_cSWFMovieClip, "new",
                             rb_SWFMovieClip_s_new, 0);

  rb_define_method(rb_cSWFMovieClip, "set_frames",
                   rb_SWFMovieClip_set_frames, 1);
  rb_define_alias(rb_cSWFMovieClip, "set_number_of_frames", "set_frames");
  rb_define_method(rb_cSWFMovieClip, "next_frame",
                   rb_SWFMovieClip_next_frame, 0);
  rb_define_method(rb_cSWFMovieClip, "label_frame",
                   rb_SWFMovieClip_label_frame, 1);
  rb_define_method(rb_cSWFMovieClip, "add",
                   rb_SWFMovieClip_add, 1);
  rb_define_method(rb_cSWFMovieClip, "remove",
                   rb_SWFMovieClip_remove, 1);
  rb_define_method(rb_cSWFMovieClip, "set_sound_stream",
                   rb_SWFMovieClip_set_sound_stream, 2);
  rb_define_method(rb_cSWFMovieClip, "set_sound_stream_at",
                   rb_SWFMovieClip_set_sound_stream_at, 3);				   
  rb_define_method(rb_cSWFMovieClip, "start_sound",
                   rb_SWFMovieClip_start_sound, 1);
  rb_define_method(rb_cSWFMovieClip, "stop_sound",
                   rb_SWFMovieClip_stop_sound, 1);
  rb_define_method(rb_cSWFMovieClip, "set_scaling_grid",
                   rb_SWFMovieClip_set_scaling_grid, 4);
  rb_define_method(rb_cSWFMovieClip, "remove_scaling_grid",
                   rb_SWFMovieClip_remove_scaling_grid, 0);
  rb_define_method(rb_cSWFMovieClip, "add_init_action",
                   rb_SWFMovieClip_add_init_action, 1);		   
  return;
}
