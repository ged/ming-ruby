/* swftextfield.c	- SWFFontCharacter class
 * $Id$
 *
 * Copyright (C) 2007 Pawel Karwowski baribal at forall dot pl
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

VALUE rb_cSWFFontCharacter;

static VALUE
rb_SWFFontCharacter_add_chars(self, ch)
	 VALUE self, ch;
{
  struct RSWFFontCharacter *f;

  Data_Get_Struct(self, struct RSWFFontCharacter, f);
  SWFFontCharacter_addChars(f->this, StringValuePtr(ch));

  return self;
}

static VALUE
rb_SWFFontCharacter_add_utf8_chars(self, ch)
	 VALUE self, ch;
{
  struct RSWFFontCharacter *f;

  Data_Get_Struct(self, struct RSWFFontCharacter, f);
  SWFFontCharacter_addUTF8Chars(f->this, StringValuePtr(ch));

  return self;
}

static VALUE
rb_SWFFontCharacter_add_all_chars(self)
	 VALUE self;
{
  struct RSWFFontCharacter *fc;
  
  Data_Get_Struct(self, struct RSWFFontCharacter, fc);
  SWFFontCharacter_addAllChars(fc->this);
  
  return self;
}
void
Init_swffontcharacter()
{
  rb_cSWFFontCharacter = rb_define_class_under(rb_mMing, "SWFFontCharacter",
					   rb_cObject);  

 
    rb_define_method(rb_cSWFFontCharacter, "add_chars",
                   rb_SWFFontCharacter_add_chars, 1);
	rb_define_method(rb_cSWFFontCharacter, "add_utf8_chars",
                   rb_SWFFontCharacter_add_utf8_chars, 1);				   
	rb_define_method(rb_cSWFFontCharacter, "add_all_chars",
                   rb_SWFFontCharacter_add_all_chars, 0); 
  /* instance methods */

  

  return;
}
