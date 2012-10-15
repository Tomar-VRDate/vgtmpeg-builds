include(`builddefs/gstcommon.m4')
include([builddefs/vgtmpeg.m4])
include([builddefs/libvpx.m4])
include([builddefs/pthreads-w32.m4])
include([builddefs/x264.m4])
include([builddefs/lame.m4])
include([builddefs/libdvdread.m4])
include([builddefs/libbluray.m4])
include([builddefs/xvid.m4])
include([builddefs/libfaac.m4])


DEFMOD([ffgmt_dist], [HEAD], [gst_dist_builder], [git], [$(NL_GIT_BASE)],,,[./autogen.sh] )
DEFMOD_MAKECMD([ffgmt_dist],[GSTDISTCMD([ffgmt_dist],[ffgmt_dist])])
DEFMOD_INSTCMD([ffgmt_dist],[:])

opt = --enable-gpl --enable-nonfree --disable-shared
opt += --disable-network  
#opt += --disable-encoders
#opt += --disable-muxers

# enable encoders
opt += --enable-libvpx --enable-encoder=libvpx 
opt += --enable-libxvid --enable-encoder=libxvid
opt += --enable-libfaac --enable-encoder=libfaac 
opt += --enable-libx264 --enable-encoder=libx264 
opt += --enable-libvorbis --enable-encoder=libvorbis --disable-encoder=vorbis
opt += --enable-encoder=mpeg4
opt += --enable-libmp3lame --enable-encoder=libmp3lame

# enable protocols
opt += --enable-protocol=bluray --enable-libbluray

# enable muxers
#opt += --enable-muxer=avi 
#opt += --enable-muxer=mp4 
#opt += --enable-muxer=asf
#opt += --enable-muxer=flv
#opt += --enable-muxer=wav

DEFMOD_COPT_ADD([vgtmpeg], [ $(opt) ] )
dnl DEFMOD_COPT_ADD([ffmpeg], [--disable-shared --enable-gpl  --disable-network --disable-muxers --enable-muxer=mp4 --disable-encoders --enable-encoder=mpeg4 ] )
DEFMOD_COPT_ADD([faac], [--disable-shared ] )

PKG =
ifeq ($(buildtype),windows-x86_32)
    PKG = pthreads-w32
endif

ifeq ($(buildtype),windows-x86_64)
    PKG = pthreads-w32
endif

PKG += xvid libbluray libdvdread lame libogg libvorbis libvpx x264 faac vgtmpeg ffgmt_dist


