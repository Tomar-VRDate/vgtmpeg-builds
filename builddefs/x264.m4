X264_CONFIGURE_BASE_OPT = $(CONFIGURE_BASE_OPT)  --enable-static  --disable-cli --disable-lavf

ifeq ($(buildtype),linux-x86_64)
	X264_CONFIGURE_BASE_OPT +=  
endif

ifeq ($(buildtype),linux-x86_32)
	X264_CONFIGURE_BASE_OPT += 
endif

ifeq ($(buildtype),windows-x86_32)
dnl libvpx gets confused with mingw32 ld and adds -m32 to it that makes it barf. this seems to work
dnl    export CROSS=i586-mingw32msvc-
dnl    export LD=
	X264_CONFIGURE_BASE_OPT +=  
endif

ifeq ($(buildtype),windows-x86_64)
	X264_CONFIGURE_BASE_OPT += 
endif

ifeq ($(buildtype),darwin-x86_32)
	X264_CONFIGURE_BASE_OPT += 
endif

ifeq ($(buildtype),darwin-x86_64)
	X264_CONFIGURE_BASE_OPT += 
endif


DEFMOD([x264], [HEAD],[x264],[git], [$(NL_GIT_BASE)projects/],,[])
DEFMOD_COPT([x264],[$(X264_CONFIGURE_BASE_OPT)])
