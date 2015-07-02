/* swfbutton.c	- SWFButton class
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

VALUE rb_cSWFButton;

void rb_free_SWFButton(p)
     struct RSWFButton *p;
{
  destroySWFButton(p->this);

  return;
}

void rb_mark_SWFButton(button)
     struct RSWFButton *button;
{
  mark_references(button->table);
 
  return;
}

static VALUE
rb_SWFButton_s_key_press(self, key)
     VALUE self, key;
{
  if(TYPE(key) != T_STRING)
    rb_raise(rb_eMingError, "Argument must be a character on keyboard.");
  if(RSTRING(key)->len != 1)
        rb_raise(rb_eMingError, "Size of argument must be just 1.");

  return INT2FIX(SWFBUTTON_KEYPRESS(RSTRING(key)->ptr[0]));
}

static VALUE
rb_SWFButton_s_on_key_press(self, key)
     VALUE self, key;
{
  if(TYPE(key) != T_STRING)
    rb_raise(rb_eMingError, "Argument must be a character on keyboard.");
  if(RSTRING(key)->len != 1)
        rb_raise(rb_eMingError, "Size of argument must be just 1.");

  return INT2FIX(SWFBUTTON_ONKEYPRESS(RSTRING(key)->ptr[0]));
}

static VALUE
rb_SWFButton_s_new(self)
     VALUE self;
{
  VALUE obj;
  struct RSWFButton *b = ALLOC(struct RSWFButton);

  b->this = newSWFButton();
  b->table = ALLOC(struct References);
  init_references(b->table);

  obj = Data_Wrap_Struct(rb_cSWFButton, rb_mark_SWFButton,
			 rb_free_SWFButton, b);
  
  return obj;
}

static VALUE
rb_SWFButton_add_character(self, character, f)
	 VALUE self, character, f;
{
  struct RSWFButton *b;
  struct RSWFCharacter *c;
  struct RSWFButtonRecord *br;
  SWFButtonRecord brec;
  VALUE obj;
  
  Data_Get_Struct(self, struct RSWFButton, b);
  Data_Get_Struct(character, struct RSWFCharacter, c);
  brec = SWFButton_addCharacter(b->this, c->this, NUM2INT(f));

  if (brec == NULL) {
    obj = Qnil;
  } else {
  add_references(b->table, character);
  br = ALLOC(struct RSWFButtonRecord);
  br->this = brec;

  br->table = ALLOC(struct References);
  init_references(br->table);
  obj = Data_Wrap_Struct(rb_cSWFButtonRecord, NULL,
                         -1, br);
  add_references(b->table, obj);
  }
  return obj;
}

static VALUE
rb_SWFButton_add_action(self, action, f)
	 VALUE self, action, f;
{
  struct RSWFButton *b;
  struct RSWFAction *a;

  Data_Get_Struct(self, struct RSWFButton, b);
  Data_Get_Struct(action, struct RSWFAction, a);

  add_references(b->table, action);
  SWFButton_addAction(b->this, a->this, NUM2INT(f));
  
  return self;
}

static VALUE
rb_SWFButton_add_sound(self, sound, f)
	 VALUE self, sound, f;
{
  struct RSWFButton *b;
  struct RSWFSound *s;
  struct RSWFSoundInstance *i;
  SWFSoundInstance si;
  VALUE obj;
  
  Data_Get_Struct(self, struct RSWFButton, b);
  Data_Get_Struct(sound, struct RSWFSound, s);
  si = SWFButton_addSound(b->this, s->this, NUM2INT(f));

  if (si == NULL) {
    obj = Qnil;
  } else {
  add_references(b->table, sound);
  i = ALLOC(struct RSWFSoundInstance);
  i->this = si;
  i->table = ALLOC(struct References);
  init_references(i->table);
  obj = Data_Wrap_Struct(rb_cSWFSoundInstance, NULL, 
                         -1, i);
  add_references(b->table, obj);
  }
  return obj;
}

static VALUE
rb_SWFButton_set_menu(self, f)
	 VALUE self, f;
{
  struct RSWFButton *b;

  Data_Get_Struct(self, struct RSWFButton, b);

  SWFButton_setMenu(b->this, NUM2INT(f));
  
  return self;
}

static VALUE
rb_SWFButton_set_up(self, character)
	 VALUE self, character;
{
  struct RSWFButton *b;
  struct RSWFCharacter *c;

  Data_Get_Struct(self, struct RSWFButton, b);
  Data_Get_Struct(character, struct RSWFCharacter, c); 

  add_references(b->table, character);
  SWFButton_addCharacter(b->this, c->this, SWFBUTTON_UP);
  
  return self;
}

static VALUE
rb_SWFButton_set_down(self, character)
	 VALUE self, character;
{
  struct RSWFButton *b;
  struct RSWFCharacter *c;

  Data_Get_Struct(self, struct RSWFButton, b);
  Data_Get_Struct(character, struct RSWFCharacter, c);

  add_references(b->table, character);
  SWFButton_addCharacter(b->this, c->this, SWFBUTTON_DOWN);
  
  return self;
}

static VALUE
rb_SWFButton_set_over(self, character)
	 VALUE self, character;
{
  struct RSWFButton *b;
  struct RSWFCharacter *c;

  Data_Get_Struct(self, struct RSWFButton, b);
  Data_Get_Struct(character, struct RSWFCharacter, c);

  add_references(b->table, character);
  SWFButton_addCharacter(b->this, c->this, SWFBUTTON_OVER);
  
  return self;
}

static VALUE
rb_SWFButton_set_hit(self, character)
	 VALUE self, character;
{
  struct RSWFButton *b;
  struct RSWFCharacter *c;

  Data_Get_Struct(self, struct RSWFButton, b);
  Data_Get_Struct(character, struct RSWFCharacter, c);

  add_references(b->table, character);
  SWFButton_addCharacter(b->this, c->this, SWFBUTTON_HIT);
  
  return self;
}

static VALUE
rb_SWFButton_set_scaling_grid(self, dx, dy, dw, dh)
	 VALUE self, dx, dy, dw, dh;
{
  struct RSWFButton *b;
  
  Data_Get_Struct(self, struct RSWFButton, b);
  SWFButton_setScalingGrid(b->this, NUM2INT(dx), NUM2INT(dy), NUM2INT(dw), NUM2INT(dh));
  
  return self;
}

static VALUE
rb_SWFButton_remove_scaling_grid(self)
         VALUE self;
{
   struct RSWFButton *b;

   Data_Get_Struct(self, struct RSWFButton, b);
   SWFButton_removeScalingGrid(b->this);

   return self;
}

void
Init_swfbutton()
{
  rb_cSWFButton = rb_define_class_under(rb_mMing, "SWFButton",
                                        rb_cObject);

  /* constants */
  rb_define_const(rb_cSWFButton, "HIT", INT2FIX(SWFBUTTON_HIT));
  rb_define_const(rb_cSWFButton, "DOWN", INT2FIX(SWFBUTTON_DOWN));
  rb_define_const(rb_cSWFButton, "OVER", INT2FIX(SWFBUTTON_OVER));
  rb_define_const(rb_cSWFButton, "UP", INT2FIX(SWFBUTTON_UP));
  rb_define_const(rb_cSWFButton, "OVER_DOWN_TO_IDLE",
                  INT2FIX(SWFBUTTON_OVERDOWNTOIDLE));
  rb_define_const(rb_cSWFButton, "IDLE_TO_OVER_DOWN",
                  INT2FIX(SWFBUTTON_IDLETOOVERDOWN));
  rb_define_const(rb_cSWFButton, "OUT_DOWN_TO_IDLE",
                  INT2FIX(SWFBUTTON_OUTDOWNTOIDLE));
  rb_define_const(rb_cSWFButton, "OUT_DOWN_TO_OVER_DOWN",
                  INT2FIX(SWFBUTTON_OUTDOWNTOOVERDOWN));
  rb_define_const(rb_cSWFButton, "OVER_DOWN_TO_OUT_DOWN",
                  INT2FIX(SWFBUTTON_OVERDOWNTOOUTDOWN));
  rb_define_const(rb_cSWFButton, "OVER_DOWN_TO_OVER_UP",
                  INT2FIX(SWFBUTTON_OVERDOWNTOOVERUP));
  rb_define_const(rb_cSWFButton, "OVER_UP_TO_OVER_DOWN",
                  INT2FIX(SWFBUTTON_OVERUPTOOVERDOWN));
  rb_define_const(rb_cSWFButton, "OVER_UP_TO_IDLE",
                  INT2FIX(SWFBUTTON_OVERUPTOIDLE));
  rb_define_const(rb_cSWFButton, "IDLE_TO_OVER_UP",
                  INT2FIX(SWFBUTTON_IDLETOOVERUP));
  rb_define_const(rb_cSWFButton, "MOUSE_UP_OUTSIDE",
                  INT2FIX(SWFBUTTON_MOUSEUPOUTSIDE));
  rb_define_const(rb_cSWFButton, "DRAG_OVER",
                  INT2FIX(SWFBUTTON_DRAGOVER));
  rb_define_const(rb_cSWFButton, "DRAG_OUT",
                  INT2FIX(SWFBUTTON_DRAGOUT));
  rb_define_const(rb_cSWFButton, "MOUSE_UP",
                  INT2FIX(SWFBUTTON_MOUSEUP));
  rb_define_const(rb_cSWFButton, "MOUSE_DOWN",
                  INT2FIX(SWFBUTTON_MOUSEDOWN));
  rb_define_const(rb_cSWFButton, "MOUSE_OUT",
                  INT2FIX(SWFBUTTON_MOUSEOUT));
  rb_define_const(rb_cSWFButton, "MOUSE_OVER",
                  INT2FIX(SWFBUTTON_MOUSEOVER));

  /* class methods */
  rb_define_singleton_method(rb_cSWFButton, "key_press",
                             rb_SWFButton_s_key_press, 1);
  rb_define_singleton_method(rb_cSWFButton, "on_key_press",
                             rb_SWFButton_s_on_key_press, 1);
  rb_define_singleton_method(rb_cSWFButton, "new",
			     rb_SWFButton_s_new, 0);

  /* instance methods */
  rb_define_method(rb_cSWFButton, "add_character",
		   rb_SWFButton_add_character, 2);
  rb_define_method(rb_cSWFButton, "add_action",
		   rb_SWFButton_add_action, 2);
  rb_define_method(rb_cSWFButton, "add_sound",
		   rb_SWFButton_add_sound, 2);
  rb_define_method(rb_cSWFButton, "set_menu",
		   rb_SWFButton_set_menu, 1);
  rb_define_method(rb_cSWFButton, "set_up",
		   rb_SWFButton_set_up, 1);
  rb_define_method(rb_cSWFButton, "set_down",
		   rb_SWFButton_set_down, 1);
  rb_define_method(rb_cSWFButton, "set_over",
		   rb_SWFButton_set_over, 1);
  rb_define_method(rb_cSWFButton, "set_hit",
		   rb_SWFButton_set_hit, 1);
  rb_define_method(rb_cSWFButton, "set_scaling_grid",
                   rb_SWFButton_set_scaling_grid, 4);
  rb_define_method(rb_cSWFButton, "remove_scaling_grid",
                   rb_SWFButton_remove_scaling_grid, 0);
				   
  return;
}
