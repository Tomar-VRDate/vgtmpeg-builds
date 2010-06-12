include(`builddefs/gstcommon.m4')

DEFMOD([glib], [RELEASE-2.22.5],[glib], [git], [$(NL_GIT_BASE_GST)])
DEFMOD_VER( [gstreamer], [RELEASE-0.10.28] )
DEFMOD_VER( [gstreamer_base], [NLRELEASE-0.10.28] )
DEFMOD_VER( [nltrans], [HEAD] )
DEFMOD_VER( [gmt_transcode], [HEAD] )
DEFMOD_VER( [gst_ffmpeg], [HEAD] )


