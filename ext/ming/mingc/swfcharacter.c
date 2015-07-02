/* swfcharacter.c	- SWFCharacter class
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

VALUE rb_cSWFCharacter;

static VALUE
rb_SWFCharacter_get_width(self)
     VALUE self;
{
  struct RSWFCharacter *b;

  Data_Get_Struct(self, struct RSWFCharacter, b);

  return rb_float_new(SWFCharacter_getWidth(b->this));
}

static VALUE
rb_SWFCharacter_get_height(self)
	 VALUE self;
{
  struct RSWFCharacter *b;

  Data_Get_Struct(self, struct RSWFCharacter, b);

  return rb_float_new(SWFCharacter_getHeight(b->this));
}

void Init_swfcharacter()
{
  rb_cSWFCharacter = rb_define_class_under(rb_mMing, "SWFCharacter",
                                       rb_cObject);

  rb_define_method(rb_cSWFCharacter, "get_width",
		   rb_SWFCharacter_get_width, 0);
  rb_define_method(rb_cSWFCharacter, "get_height",
		   rb_SWFCharacter_get_height, 0);
  return;
}

