include(`builddefs/gstcommon.m4')
include([builddefs/ffmpeg.m4])
include([builddefs/libvpx.m4])
include([builddefs/pthreads-w32.m4])

DEFMOD([ffgmt_dist], [HEAD], [gst_dist_builder], [git], [$(NL_GIT_BASE)],,,[./autogen.sh] )
DEFMOD_MAKECMD([ffgmt_dist],[GSTDISTCMD([ffgmt_dist])])
DEFMOD_INSTCMD([ffgmt_dist],[:])

DEFMOD_COPT_ADD([ffmpeg], [--enable-gpl  --enable-postproc --enable-nonfree --enable-libx264 --enable-libfaac --enable-libvpx --disable-network --disable-muxers --enable-muxer=mp4 --disable-encoders --enable-encoder=libvpx --enable-encoder=libfaac --enable-encoder=libx264 --enable-encoder=mpeg4 ] )
dnl DEFMOD_COPT_ADD([ffmpeg], [--enable-gpl  --disable-network --disable-muxers --enable-muxer=mp4 --disable-encoders --enable-encoder=mpeg4 ] )
DEFMOD_COPT_ADD([faac], [--disable-shared ] )

PKG =
ifeq ($(buildtype),windows-x86_32)
    PKG = pthreads-w32
endif

PKG += libvpx x264 faac ffmpeg ffgmt_dist


