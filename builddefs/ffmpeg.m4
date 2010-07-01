
FFMPEG_CONFIGURE_BASE_OPT = --prefix=$(prefix)

ifeq ($(buildtype),linux-x86_64)
	FFMPEG_CONFIGURE_BASE_OPT = --prefix=$(prefix) --enable-pthreads 
endif

ifeq ($(buildtype),linux-x86_32)
	FFMPEG_CONFIGURE_BASE_OPT = --prefix=$(prefix) --enable-pthreads 
endif

ifeq ($(buildtype),windows-x86_32)
	FFMPEG_CONFIGURE_BASE_OPT = --prefix=$(prefix) --arch=i386 --enable-cross-compile --target-os=mingw32 --cross-prefix=i586-mingw32msvc- --enable-memalign-hack
endif

ifeq ($(buildtype),darwin-x86_32)
	FFMPEG_CONFIGURE_BASE_OPT = --prefix=$(prefix) --arch=i386
endif

ifeq ($(buildtype),darwin-x86_64)
	FFMPEG_CONFIGURE_BASE_OPT =  --prefix=$(prefix) --arch=x86_64
endif

DEFMOD([ffmpeg],[0.5.2],,[svn],[$(SVN_BASE)])
DEFMOD_COPT([ffmpeg],[$(FFMPEG_CONFIGURE_BASE_OPT)])

