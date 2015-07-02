/* mingc.h	-- the basic definitions
 *
 * $Id$
 * Copyright (C) 2004 IKEGAMI Daisuke <ikegami@madscientist.jp>
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

#ifndef _MINGC_H
#define _MINGC_H

struct References {
  unsigned long size;
  VALUE *item;
};

#define DECLARE_SWF_CLASS(name) \
  struct RSWF ## name \
  { \
    SWF ## name this; \
    struct References *table; \
    void *option; \
  }; \
  extern VALUE rb_cSWF ## name; \
  void rb_free_SWF##name(struct RSWF ## name *p);

DECLARE_SWF_CLASS(Action);
DECLARE_SWF_CLASS(BinaryData);
DECLARE_SWF_CLASS(Bitmap);
DECLARE_SWF_CLASS(Block);
DECLARE_SWF_CLASS(Blur);
DECLARE_SWF_CLASS(Button);
DECLARE_SWF_CLASS(ButtonRecord);
DECLARE_SWF_CLASS(BrowserFont);
DECLARE_SWF_CLASS(Character);
DECLARE_SWF_CLASS(Color);
DECLARE_SWF_CLASS(CXform);
DECLARE_SWF_CLASS(DisplayItem);
DECLARE_SWF_CLASS(Fill);
DECLARE_SWF_CLASS(FillStyle);
DECLARE_SWF_CLASS(Filter);
DECLARE_SWF_CLASS(FilterMatrix);
DECLARE_SWF_CLASS(Font);
DECLARE_SWF_CLASS(FontCharacter);
DECLARE_SWF_CLASS(Gradient);
DECLARE_SWF_CLASS(InitAction);
DECLARE_SWF_CLASS(LineStyle);
DECLARE_SWF_CLASS(Matrix);
DECLARE_SWF_CLASS(Morph);
DECLARE_SWF_CLASS(Movie);
DECLARE_SWF_CLASS(MovieClip);
DECLARE_SWF_CLASS(Position);
DECLARE_SWF_CLASS(Shadow);
DECLARE_SWF_CLASS(Shape);
DECLARE_SWF_CLASS(Sound);
DECLARE_SWF_CLASS(SoundInstance);
DECLARE_SWF_CLASS(SoundStream);
DECLARE_SWF_CLASS(Text);
DECLARE_SWF_CLASS(TextField);
DECLARE_SWF_CLASS(PrebuiltClip);
DECLARE_SWF_CLASS(VideoStream);

/* initialize */
void Init_mingc();
void Init_swfaction();
void Init_swfbinarydata();
void Init_swfbitmap();
void Init_swfblendmode();
void Init_swfblur();
void Init_swfbrowserfont();
void Init_swfbutton();
void Init_swfbuttonrecord();
void Init_swfcharacter();
void Init_swfcolor();
void Init_swfcxform();
void Init_swfdisplayitem();
void Init_swffont();
void Init_swffontcharacter();
void Init_swffill();
void Init_swffillstyle();
void Init_swffilter();
void Init_swffiltermatrix();
void Init_swffont();
void Init_swfgradient();
void Init_swfinitaction();
void Init_swflinestyle();
void Init_swfmatrix();
void Init_swfmorph();
void Init_swfmovie();
void Init_swfmovieclip();
void Init_swfposition();
void Init_swfshadow();
void Init_swfshape();
void Init_swfsound();
void Init_swfsoundinstance();
void Init_swfsoundstream();
void Init_swftext();
void Init_swftextfield();
void Init_swfprebuiltclip();
void Init_swfvideostream();

/* modules and classes */
extern VALUE rb_mMing;

/* Exceptions */
extern VALUE rb_eMingError;

/* reference table for GC */
int init_references(struct References *t);
int add_references(struct References *t, VALUE s);
int mark_references(struct References *t);

#endif
