include(`builddefs/gstcommon.m4')
include([builddefs/ffmpeg.m4])

DEFMOD([ffgmt_dist], [HEAD], [gst_dist_builder], [git], [$(NL_GIT_BASE)],,,[./autogen.sh] )
DEFMOD_MAKECMD([ffgmt_dist],[GSTDISTCMD([ffgmt_dist])])
DEFMOD_INSTCMD([ffgmt_dist],[:])

DEFMOD_COPT_ADD([ffmpeg], [--enable-gpl --enable-nonfree --enable-libx264 --enable-libfaac --disable-muxers --enable-muxer=mp4 --disable-encoders --enable-encoder=mpeg4 ] )
DEFMOD_COPT_ADD([faac], [--disable-shared ] )
PKG= x264 faac ffmpeg ffgmt_dist


