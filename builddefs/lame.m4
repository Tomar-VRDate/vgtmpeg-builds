LAME_VERSION = master
LAME_BASE = BB_GIT_BASE
LAME_SRC_BASE = lame-vgtmpeg
LAME_GET_TYPE = git
LAME_COPT =  $(CONFIGURE_BASE_OPT) --disable-shared --enable-static --disable-frontend --disable-decoder


ifeq ($(buildtype),linux-x86_64)
endif

ifeq ($(buildtype),linux-x86_32)
endif

ifeq ($(buildtype),windows-x86_32)
    LAME_VERSION = lame-3.99.1.w32
dnl DEFMOD_TOOLADD([lame],[CFLAGS],[ -DFORCEINLINE= ]) 
endif

ifeq ($(buildtype),windows-x86_64)
dnl  DEFMOD_TOOLADD([lame],[CFLAGS],[ -DFORCEINLINE= ]) 
endif

ifeq ($(buildtype),darwin-x86_32)
endif

ifeq ($(buildtype),darwin-x86_64)
endif



DEFMOD([lame],[$(LAME_VERSION)],[$(LAME_SRC_BASE)],[$(LAME_GET_TYPE)],[$(BB_GIT_BASE)],[$(LAME_COPT)])
