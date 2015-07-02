/*
 * Ming/Ruby
 * $Id$
 *
 *  Copyright C 2004 Ikegami Daisuke. All rights reserved.
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <ming.h>
#include "ruby.h"
#include "mingc.h"

VALUE rb_cSWFBitmap;

#define RAISE_NOF(s) \
  (rb_raise(rb_eIOError, "No such file or directory - %s", (s)))


void rb_free_SWFBitmap(b)
     struct RSWFBitmap *b;
{
  FILE *fp = b->option;
  destroySWFBitmap(b->this);
  
  fclose(fp);

  return;
}

static VALUE
rb_SWFBitmap_s_new(argc, argv, self)
     int argc;
     VALUE *argv, self;
{
  struct RSWFBitmap *b = ALLOC(struct RSWFBitmap);
  VALUE obj, f, a;
  char *filename, *alpha_filename, *ext;
  FILE *fp = NULL, *afp = NULL;
  size_t len;

  rb_scan_args(argc, argv, "11", &f, &a);

  filename = StringValuePtr(f);
  fp = fopen(filename, "rb");
  if (fp == NULL)
    RAISE_NOF(filename);

  if(NIL_P(a)) {
    len = RSTRING(f)->len;
    if(len > 5) {
      ext = &filename[len - 5];
      if(strncmp(ext, ".jpeg", 5) == 0) {
	b->this = (SWFBitmap)newSWFJpegBitmap(fp);
      }
    }
    if (len > 4) {
      ext = &filename[len - 4];
      if (strncmp(ext, ".jpg", 4) == 0) {
	b->this = (SWFBitmap)newSWFJpegBitmap(fp);
      } else if (strncmp(ext, ".dbl", 4) == 0) {
	b->this = (SWFBitmap)newSWFDBLBitmap(fp);
      } else if (strncmp(ext, ".gif", 4) == 0) {
	b->this = (SWFBitmap)newSWFDBLBitmapData_fromGifFile(filename);
      } else if (strncmp(ext, ".png", 4) == 0) {
	b->this = (SWFBitmap)newSWFDBLBitmapData_fromPngFile(filename);
      }
    } else {
      rb_raise(rb_eNotImpError, "do not support the format - %s", filename);
    }
  } else {
    
    alpha_filename = StringValuePtr(a);
    afp = fopen(alpha_filename, "rb");
    if (afp == NULL) RAISE_NOF(alpha_filename);
    
    b->this = (SWFBitmap)newSWFJpegWithAlpha_fromInput(newSWFInput_file(fp), newSWFInput_file(afp));
  }
  b->option = fp;
  
  obj = Data_Wrap_Struct(rb_cSWFBitmap, NULL,
			 rb_free_SWFBitmap, b);

  return obj;
}

static VALUE
rb_SWFBitmap_get_width(self)
     VALUE self;
{
  struct RSWFBitmap *b;

  Data_Get_Struct(self, struct RSWFBitmap, b);

  return INT2NUM(SWFBitmap_getWidth(b->this));
}

static VALUE
rb_SWFBitmap_get_height(self)
	 VALUE self;
{
  struct RSWFBitmap *b;

  Data_Get_Struct(self, struct RSWFBitmap, b);

  return INT2NUM(SWFBitmap_getHeight(b->this));
}

void Init_swfbitmap()
{
  rb_cSWFBitmap = rb_define_class_under(rb_mMing, "SWFBitmap", rb_cObject);

  rb_define_singleton_method(rb_cSWFBitmap, "new",
			     rb_SWFBitmap_s_new, -1);

  rb_define_method(rb_cSWFBitmap, "get_width",
		   rb_SWFBitmap_get_width, 0);
  rb_define_method(rb_cSWFBitmap, "get_height",
		   rb_SWFBitmap_get_height, 0);
  return;
}
