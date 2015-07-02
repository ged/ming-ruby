/* swffiltermatrix.c     	- SWFFilterMatrix class
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

VALUE rb_cSWFFilterMatrix;

void rb_free_SWFFilterMatrix(fm)
	 struct RSWFFilterMatrix *fm;
{
  destroySWFFilterMatrix(fm->this);
  
  return;
}

static VALUE
rb_SWFFilterMatrix_new(self, cols, rows, vals)
	 VALUE self, cols, rows, *vals;
{
  VALUE obj;
  struct RSWFFilterMatrix *fm = ALLOC(struct RSWFFilterMatrix);
  int i;

  int size = RARRAY(vals)->len;
  float *tab = (float *)malloc(cols*rows*sizeof(float));
  VALUE *ptr = RARRAY(vals)->ptr;

  for (i=0;i<size;i++,ptr++) {
  
     tab[i] = NUM2DBL(*ptr);

  }
  
  fm->this = newSWFFilterMatrix(NUM2INT(cols), NUM2INT(rows), (float *) tab);
  if (fm->this == NULL)
    rb_raise(rb_eMingError, "Bad arguments given, need 3 arguments - %s", NULL);
  fm->table = ALLOC(struct References);
  init_references(fm->table);

  obj = Data_Wrap_Struct(rb_cSWFFilterMatrix, NULL,
			 rb_free_SWFFilterMatrix, fm);

  return obj;
}

void Init_swffiltermatrix()
{
  rb_cSWFFilterMatrix = rb_define_class_under(rb_mMing, "SWFFilterMatrix", 
                                           rb_cObject);
  
  rb_define_singleton_method(rb_cSWFFilterMatrix, "new", rb_SWFFilterMatrix_new, 3);
  
 
  return;
}

