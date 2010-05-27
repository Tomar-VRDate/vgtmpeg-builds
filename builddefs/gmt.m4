include(`builddefs/gstcommon.m4')

DEFMOD_VER( [nltrans], [HEAD] )
DEFMOD_VER( [gmt_transcode], [HEAD] )
DEFMOD_VER( [gst_ffmpeg], [HEAD] )

DEFMOD_COPT_ADD([gstreamer], [ --disable-registry]) 
DEFMOD_COPT_ADD([gst_ffmpeg], [ --with-ffmpeg-extra-configure="--disable-muxers --enable-muxer=null --disable-encoders --enable-encoder=mpeg4" ])
