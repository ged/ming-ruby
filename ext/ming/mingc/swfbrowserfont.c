/* swfbrowserfont.c	- SWFBrowserFont class
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

VALUE rb_cSWFBrowserFont;

void rb_free_SWFBrowserFont(p)
     struct RSWFBrowserFont *p;
{
  destroySWFBrowserFont(p->this);
  
  return;  
}

static VALUE
rb_SWFBrowserFont_s_new(self, name)
     VALUE self, name;
{
  struct RSWFBrowserFont *f = ALLOC(struct RSWFBrowserFont);
  VALUE obj;

  f->this = newSWFBrowserFont(StringValuePtr(name));
  f->table = ALLOC(struct References);
  init_references(f->table);

  obj = Data_Wrap_Struct(rb_cSWFBrowserFont, 0, 
                         rb_free_SWFBrowserFont, f);
  return obj;
}


void Init_swfbrowserfont()
{
  rb_cSWFBrowserFont = rb_define_class_under(rb_mMing, 
                                             "SWFBrowserFont", rb_cObject);

  rb_define_singleton_method(rb_cSWFBrowserFont, "new",
                             rb_SWFBrowserFont_s_new, 1);
  return;
}
