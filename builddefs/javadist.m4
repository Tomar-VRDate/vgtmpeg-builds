include(`builddefs/gstcommon.m4')

DEFMOD_VER( [nltrans], [HEAD] )
DEFMOD_VER( [gmt_transcode], [HEAD] )
DEFMOD_VER( [gst_ffmpeg], [HEAD] )

DEFMOD_COPT_ADD([gstreamer], [ --disable-registry] )
