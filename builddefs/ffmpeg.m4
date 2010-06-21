include(`builddefs/gstcommon.m4')

DEFMOD_COPT_ADD([ffmpeg], [--enable-gpl --enable-nonfree --enable-libx264 --enable-libfaac --enable-pthreads] )
DEFMOD_COPT_ADD([faac], [--disable-shared ] )
PKG= x264 faac ffmpeg


