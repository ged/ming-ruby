/* swfmovie.c	- SWFMovie class
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

VALUE rb_cSWFMovie;

void rb_free_SWFMovie(p)
	 struct RSWFMovie *p;
{
  destroySWFMovie(p->this); 
  
  return;  
}

static void rb_mark_SWFMovie(m)
     struct RSWFMovie *m;
{
  mark_references(m->table);

  return;
}

static VALUE
rb_SWFMovie_s_new(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  VALUE obj, version;
  struct RSWFMovie *m = ALLOC(struct RSWFMovie);

  rb_scan_args(argc, argv, "01", &version);

  if(NIL_P(version))
    m->this = newSWFMovie();
  else
    m->this = newSWFMovieWithVersion(NUM2INT(version));

  m->table = ALLOC(struct References);
  init_references(m->table);

  obj = Data_Wrap_Struct(rb_cSWFMovie, rb_mark_SWFMovie,
			  rb_free_SWFMovie, m);
  
  return obj;
}

static VALUE
rb_SWFMovie_set_rate(self, f)
	 VALUE self, f;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_setRate(m->this, (float) NUM2DBL(f));

  return self;
}

static VALUE
rb_SWFMovie_set_dimension(self, w, h)
     VALUE self, w, h;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_setDimension(m->this, (float) NUM2DBL(w), (float) NUM2DBL(h));

  return self;
}

static VALUE
rb_SWFMovie_set_number_of_frames(self, n)
	 VALUE self, n;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_setNumberOfFrames(m->this, FIX2INT(n));

  return self;
}

static VALUE
rb_SWFMovie_add_export(self, block, n)
	 VALUE self, block, n;
{
  struct RSWFMovie *m;
  struct RSWFBlock *b;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  Data_Get_Struct(block, struct RSWFBlock, b);

  add_references(m->table, n);
  SWFMovie_addExport(m->this, b->this, StringValuePtr(n));
  
  return self;
}

static VALUE
rb_SWFMovie_assign_symbol(self, character, n)
	 VALUE self, character, n;
{
  struct RSWFMovie *m;
  struct RSWFCharacter *c;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  Data_Get_Struct(character, struct RSWFCharacter, c);

  add_references(m->table, character);
  SWFMovie_assignSymbol(m->this, (SWFCharacter)c->this, StringValuePtr(n));
  
  return self;
}


static VALUE
rb_SWFMovie_define_scene(self, offset, n)
	 VALUE self, offset, n;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);

  SWFMovie_defineScene(m->this, NUM2UINT(offset), StringValuePtr(n));
  
  return self;
}


static VALUE
rb_SWFMovie_write_exports(self)
         VALUE self;
{
   struct RSWFMovie *m;

   Data_Get_Struct(self, struct RSWFMovie, m);
   SWFMovie_writeExports(m->this);

   return self;
}

static VALUE
rb_SWFMovie_set_background(self, r, g, b)
	 VALUE self, r, g, b;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_setBackground(m->this, FIX2INT(r), FIX2INT(g), FIX2INT(b));
  
  return self;
}

static VALUE
rb_SWFMovie_add(self, b)
	 VALUE self, b;
{
  struct RSWFMovie *m;
  struct RSWFBlock *p;
  struct RSWFDisplayItem *i;
  SWFDisplayItem item;
  VALUE obj;

  Data_Get_Struct(self, struct RSWFMovie, m);
  Data_Get_Struct(b, struct RSWFBlock, p);
  
  item = SWFMovie_add(m->this, p->this);

  if (item == NULL) {
    obj = Qnil;
  } else {
    add_references(m->table, b);
    i = ALLOC(struct RSWFDisplayItem);
    i->this = item;
    i->table = ALLOC(struct References);
    init_references(i->table);
    
    obj = Data_Wrap_Struct(rb_cSWFDisplayItem, NULL,
			   -1, i);
    add_references(m->table, obj);
  }

  return obj;
}

static VALUE
rb_SWFMovie_remove(self, i)
	 VALUE self, i;
{
  struct RSWFMovie *m;
  struct RSWFDisplayItem *p;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  Data_Get_Struct(i, struct RSWFDisplayItem, p);
  
  add_references(m->table, i);
  SWFMovie_remove(m->this, p->this);

  return self;
}

static VALUE
rb_SWFMovie_next_frame(self)
	 VALUE self;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_nextFrame(m->this);

  return self;
}

static VALUE
rb_SWFMovie_label_frame(self, label)
	 VALUE self, label;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_labelFrame(m->this, StringValuePtr(label));

  return self;
}

static VALUE
rb_SWFMovie_protect(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFMovie *m;
  VALUE p;
  char *pass;
  
  rb_scan_args(argc, argv, "01", &p);
  
  if(p == Qnil) {
      pass = "";
  } else {
      pass = StringValuePtr(p);
  }

  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_protect(m->this, pass);

  return self;
}


static VALUE
rb_SWFMovie_add_Metadata(self, data)
	 VALUE self, data;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_addMetadata(m->this, StringValuePtr(data));

  return self;
}


static VALUE
rb_SWFMovie_named_anchor(self, label)
	 VALUE self, label;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_namedAnchor(m->this, StringValuePtr(label));

  return self;
}


static void simpleOutputMethod(byte b, void *data);
static void simpleOutputMethod(b, data)
	 byte b;
	 void *data;
{
  putchar(b);
}

static VALUE
rb_SWFMovie_output(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  int len, level;
  struct RSWFMovie *m;
  VALUE lobj;

  rb_scan_args(argc, argv, "01", &lobj);
  if(NIL_P(lobj))
    level = 0;
  else
    level = NUM2INT(lobj);

  Data_Get_Struct(self, struct RSWFMovie, m);
  Ming_setSWFCompression(level);
  len = SWFMovie_output(m->this, simpleOutputMethod, NULL);
  
  return INT2NUM(len);
}

static VALUE
rb_SWFMovie_save(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  struct RSWFMovie *m;
  int count, level;
  VALUE s, lobj;

  rb_scan_args(argc, argv, "11", &s, &lobj);
  if(NIL_P(lobj))
    level = 0;
  else
    level = NUM2INT(lobj);

  Data_Get_Struct(self, struct RSWFMovie, m);
  Ming_setSWFCompression(level);
  count = SWFMovie_save(m->this, StringValuePtr(s));

  return INT2NUM(count);
}

static VALUE
rb_SWFMovie_set_sound_stream(self, sound)
	 VALUE self, sound;
{
  struct RSWFMovie *m;
  struct RSWFSoundStream *s;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  Data_Get_Struct(sound, struct RSWFSoundStream, s);

  add_references(m->table, sound);
  SWFMovie_setSoundStream(m->this, s->this);
  
  return self;
}

static VALUE
rb_SWFMovie_set_sound_stream_at(self, sound, r)
     VALUE self, sound, r;
{
  struct RSWFMovie *m;
  struct RSWFSoundStream *s;

  Data_Get_Struct(self, struct RSWFMovie, m);
  Data_Get_Struct(sound, struct RSWFSoundStream, s);

  add_references(m->table, sound);
  SWFMovie_setSoundStreamAt(m->this, s->this, NUM2DBL(r));

  return self;
}

static VALUE
rb_SWFMovie_start_sound(self, sound)
	 VALUE self, sound;
{
  struct RSWFMovie *m;
  struct RSWFSound *s;
  struct RSWFSoundInstance *i;
  SWFSoundInstance si;
  VALUE obj;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  Data_Get_Struct(sound, struct RSWFSound, s);
  si = SWFMovie_startSound(m->this, s->this);

  if (si == NULL) {
    obj = Qnil;
  } else {
  add_references(m->table, sound);
  i = ALLOC(struct RSWFSoundInstance);
  i->this = si;
  i->table = ALLOC(struct References);
  init_references(i->table);
  obj = Data_Wrap_Struct(rb_cSWFSoundInstance, NULL, 
                         -1, i);
  add_references(m->table, obj);
  }
  return obj;
}

static VALUE
rb_SWFMovie_stop_sound(self, sound)
	 VALUE self, sound;
{
  struct RSWFMovie *m;
  struct RSWFSound *s;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  Data_Get_Struct(sound, struct RSWFSound, s);

  add_references(m->table, sound);
  SWFMovie_stopSound(m->this, s->this);
  
  return self;
}

static VALUE
rb_SWFMovie_import_character(self, filename, name)
     VALUE self, filename, name;
{
  struct RSWFMovie *m;
  struct RSWFCharacter *b = ALLOC(struct RSWFCharacter);
  VALUE obj;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  b->this = SWFMovie_importCharacter(m->this, 
                                     StringValuePtr(filename), StringValuePtr(name));
  b->table = ALLOC(struct References);
  init_references(b->table);

  obj = Data_Wrap_Struct(rb_cSWFCharacter, NULL, -1, b);
  add_references(m->table, obj);
  
  return obj;
}

static VALUE
rb_SWFMovie_set_network_access(self, df)
	 VALUE self, df;
{
  struct RSWFMovie *m;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_setNetworkAccess((SWFMovie) m->this,
		     NUM2INT(df));
  
  return self;
}

static VALUE
rb_SWFMovie_set_script_limits(self, dmr, dt)
	 VALUE self, dmr, dt;
{
  struct RSWFMovie *m;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_setScriptLimits((SWFMovie) m->this,
		     NUM2INT(dmr), NUM2INT(dt));
  
  return self;
}

static VALUE
rb_SWFMovie_set_tab_index(self, dd, di)
	 VALUE self, dd, di;
{
  struct RSWFMovie *m;
  
  Data_Get_Struct(self, struct RSWFMovie, m);
  SWFMovie_setTabIndex((SWFMovie) m->this,
		     NUM2INT(dd), NUM2INT(di));
  
  return self;
}

static VALUE
rb_SWFMovie_add_font(self, font)
	 VALUE self, font;
{
  struct RSWFMovie *m;
  struct RSWFFont *f;
  struct RSWFFontCharacter *fc;
  SWFFontCharacter fontchar;
  VALUE obj;

  Data_Get_Struct(self, struct RSWFMovie, m);
  Data_Get_Struct(font, struct RSWFFont, f);

  add_references(m->table, font);
  fontchar = SWFMovie_addFont(m->this, f->this);

  if (fontchar == NULL)
    obj = Qnil;
  else {
    fc = ALLOC(struct RSWFFontCharacter);
    fc->this = fontchar;
    fc->table = ALLOC(struct References);
    init_references(fc->table);

    obj =  Data_Wrap_Struct(rb_cSWFFontCharacter, 0,
			-1, fc);

  add_references(m->table, obj);
  }

  return obj;
}

static VALUE
rb_SWFMovie_get_rate(self)
     VALUE self;
{
  struct RSWFMovie *m;

  Data_Get_Struct(self, struct RSWFMovie, m);

  return rb_float_new(SWFMovie_getRate(m->this));
}

void Init_swfmovie()
{
  rb_cSWFMovie = rb_define_class_under(rb_mMing, "SWFMovie",
                                       rb_cObject);

  rb_define_singleton_method(rb_cSWFMovie, "new",
                             rb_SWFMovie_s_new, -1);

  rb_define_method(rb_cSWFMovie, "set_rate",
                   rb_SWFMovie_set_rate, 1);
  rb_define_method(rb_cSWFMovie, "set_dimension",
                   rb_SWFMovie_set_dimension, 2);
  rb_define_method(rb_cSWFMovie, "set_number_of_frames",
                   rb_SWFMovie_set_number_of_frames, 1);
  rb_define_method(rb_cSWFMovie, "add_export",
                   rb_SWFMovie_add_export, 2);
  rb_define_method(rb_cSWFMovie, "assign_symbol",
                   rb_SWFMovie_assign_symbol, 2);
  rb_define_method(rb_cSWFMovie, "define_scene",
                   rb_SWFMovie_define_scene, 2);		   
  rb_define_method(rb_cSWFMovie, "write_exports",
                    rb_SWFMovie_write_exports, 0);
  rb_define_method(rb_cSWFMovie, "set_background",
                   rb_SWFMovie_set_background, 3);
  rb_define_method(rb_cSWFMovie, "add",
                   rb_SWFMovie_add, 1);
  rb_define_method(rb_cSWFMovie, "remove",
                   rb_SWFMovie_remove, 1);
  rb_define_method(rb_cSWFMovie, "next_frame",
                   rb_SWFMovie_next_frame, 0);
  rb_define_method(rb_cSWFMovie, "label_frame",
                   rb_SWFMovie_label_frame, 1);
  rb_define_method(rb_cSWFMovie, "protect",
                   rb_SWFMovie_protect, -1);		   
  rb_define_method(rb_cSWFMovie, "add_metadata",
                   rb_SWFMovie_add_Metadata, 1);
  rb_define_method(rb_cSWFMovie, "named_anchor",
                   rb_SWFMovie_named_anchor, 1);		   
  rb_define_method(rb_cSWFMovie, "output",
                   rb_SWFMovie_output, -1);
  rb_define_method(rb_cSWFMovie, "save",
                   rb_SWFMovie_save, -1);
  rb_define_method(rb_cSWFMovie, "set_sound_stream",
                   rb_SWFMovie_set_sound_stream, 1);
  rb_define_method(rb_cSWFMovie, "set_sound_stream_at",
                   rb_SWFMovie_set_sound_stream_at, 2);
  rb_define_method(rb_cSWFMovie, "start_sound",
                   rb_SWFMovie_start_sound, 1);
  rb_define_method(rb_cSWFMovie, "stop_sound",
                   rb_SWFMovie_stop_sound, 1);
  rb_define_method(rb_cSWFMovie, "import_character",
                   rb_SWFMovie_import_character, 2);
  rb_define_method(rb_cSWFMovie, "set_network_access",
                   rb_SWFMovie_set_network_access, 1);
  rb_define_method(rb_cSWFMovie, "set_script_limits",
                   rb_SWFMovie_set_script_limits, 2);					   
  rb_define_method(rb_cSWFMovie, "set_tab_index",
                   rb_SWFMovie_set_tab_index, 2);
  rb_define_method(rb_cSWFMovie, "add_font",
                   rb_SWFMovie_add_font, 1);
  rb_define_method(rb_cSWFMovie, "get_rate",
                   rb_SWFMovie_get_rate, 0);				   

  return;
}
