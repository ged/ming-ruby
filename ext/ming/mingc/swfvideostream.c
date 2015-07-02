#include <ming.h>
#include "ruby.h"
#include "mingc.h"

VALUE rb_cSWFVideoStream;

void rb_free_SWFVideoStream(p)
     struct RSWFVideoStream *p;
{
  destroySWFVideoStream(p->this);

  return;
}


static VALUE
rb_SWFVideoStream_s_new(argc, argv, self)
	 int argc;
	 VALUE *argv, self;
{
  struct RSWFVideoStream *stream = ALLOC(struct RSWFVideoStream);
  VALUE obj, filename;

  rb_scan_args(argc, argv, "01", &filename);

  if(NIL_P(filename))
  {
    stream->option = NULL;
    stream->this = newSWFVideoStream();
  }
  else
  {
    FILE *fp;
    fp = fopen ( StringValuePtr(filename), "rb" );
    stream->option = fp;
    stream->this = newSWFVideoStream_fromFile(fp);
  }
  
  obj = Data_Wrap_Struct(rb_cSWFVideoStream, 0, rb_free_SWFVideoStream, stream);

  return obj;
}


static VALUE
rb_SWFVideoStream_set_dimension(self, w, h)
         VALUE self, w, h;
{
  struct RSWFVideoStream *vstream;

  Data_Get_Struct(self, struct RSWFVideoStream, vstream);
  SWFVideoStream_setDimension(vstream->this, (int) NUM2INT(w), (int) NUM2INT(h));

  return self;
}

static VALUE
rb_SWFVideoStream_get_num_frames(self)
	 VALUE self;
{
  struct RSWFVideoStream *m;
  
  Data_Get_Struct(self, struct RSWFVideoStream, m);

  return INT2NUM(SWFVideoStream_getNumFrames(m->this));
}

static VALUE
rb_SWFVideoStream_has_audio(self)
	 VALUE self;
{
  struct RSWFVideoStream *m;
  
  Data_Get_Struct(self, struct RSWFVideoStream, m);

  return INT2NUM(SWFVideoStream_hasAudio(m->this));
}

static VALUE
rb_SWFVideoStream_set_frame_mode(self, mode)
         VALUE self, mode;
{
  struct RSWFVideoStream *vstream;

  Data_Get_Struct(self, struct RSWFVideoStream, vstream);
  SWFVideoStream_setFrameMode(vstream->this, (int) NUM2INT(mode));

  return self;
}

static VALUE
rb_SWFVideoStream_next_frame(self)
	 VALUE self;
{
  struct RSWFVideoStream *m;
  
  Data_Get_Struct(self, struct RSWFVideoStream, m);

  return INT2NUM(SWFVideoStream_nextFrame(m->this));
}

static VALUE
rb_SWFVideoStream_seek(self, frame, whence)
         VALUE self, frame, whence;
{
  struct RSWFVideoStream *vstream;

  Data_Get_Struct(self, struct RSWFVideoStream, vstream);

  return INT2NUM(SWFVideoStream_seek(vstream->this, (int) NUM2INT(frame), (int) NUM2INT(whence)));

}

void
Init_swfvideostream()
{
  rb_cSWFVideoStream = rb_define_class_under(rb_mMing, "SWFVideoStream", rb_cObject);
  
  rb_define_const(rb_cSWFVideoStream, "MODE_AUTO",
		   INT2FIX(SWFVIDEOSTREAM_MODE_AUTO));
  rb_define_const(rb_cSWFVideoStream, "MODE_MANUAL", 
                   INT2FIX(SWFVIDEOSTREAM_MODE_MANUAL));
  rb_define_const(rb_cSWFVideoStream, "SEEK_SET", 
                   INT2FIX(SEEK_SET));		   
  rb_define_const(rb_cSWFVideoStream, "SEEK_END", 
                   INT2FIX(SEEK_END));
  rb_define_const(rb_cSWFVideoStream, "SEEK_CUR", 
                   INT2FIX(SEEK_CUR));		   		    		   
  rb_define_singleton_method(rb_cSWFVideoStream, "new", rb_SWFVideoStream_s_new, -1);

  rb_define_method(rb_cSWFVideoStream, "set_dimension", rb_SWFVideoStream_set_dimension, 2);
  rb_define_method(rb_cSWFVideoStream, "get_num_frames", rb_SWFVideoStream_get_num_frames, 0);
  rb_define_method(rb_cSWFVideoStream, "has_audio", rb_SWFVideoStream_has_audio, 0);  
  rb_define_method(rb_cSWFVideoStream, "set_frame_mode", rb_SWFVideoStream_set_frame_mode, 1);
  rb_define_method(rb_cSWFVideoStream, "next_frame", rb_SWFVideoStream_next_frame, 0);
  rb_define_method(rb_cSWFVideoStream, "seek", rb_SWFVideoStream_seek, 2);  
  
  rb_define_alias(rb_cSWFVideoStream, "get_frames", "get_num_frames");
}
