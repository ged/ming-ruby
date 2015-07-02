/* util.c	- for GC utilities
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

#include <string.h>
#include <ctype.h>
#include <ming.h>
#include "ruby.h"
#include "mingc.h"

int init_references(table)
     struct References *table;
{
  table->size = 0;
  table->item = NULL;

  return 0;
}

int add_references(table, src)
     struct References *table;
     VALUE src;
{
  unsigned long n;

  n = table->size;

  if(n == 0) {
    table->item = ALLOC(VALUE);
  } else {
    REALLOC_N(table->item, VALUE, n + 1);
  }

  table->item[n] = src;
  table->size++;

  return 0;
}
	 
int mark_references(table)
     struct References *table;
{
  unsigned long i;
  VALUE *p = table->item;

  for(i = 0; i < table->size; i++){ 
    rb_gc_mark(*p);
    p++;
  }

  return 0;
}
