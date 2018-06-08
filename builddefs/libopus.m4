OPUS_VERSION = v1.2.1
OPUS_BASE = GH_GIT_BASE
OPUS_SRC_BASE = opus
OPUS_GET_TYPE = git
OPUS_COPT = $(CONFIGURE_BASE_OPT) --disable-shared --enable-static --disable-doc --disable-extra-programs



ifeq ($(buildtype),linux-x86_64)
endif

ifeq ($(buildtype),linux-x86_32)
endif

ifeq ($(buildtype),windows-x86_32)
dnl DEFMOD_TOOLADD([lame],[CFLAGS],[ -DFORCEINLINE= ]) 
endif

ifeq ($(buildtype),windows-x86_64)
dnl  DEFMOD_TOOLADD([lame],[CFLAGS],[ -DFORCEINLINE= ]) 
endif

ifeq ($(buildtype),darwin-x86_32)
endif

ifeq ($(buildtype),darwin-x86_64)
endif



DEFMOD([opus],[$(OPUS_VERSION)],[$(OPUS_SRC_BASE)],[$(OPUS_GET_TYPE)],[$(GH_GIT_BASE)],[$(OPUS_COPT)])
DEFMOD_CONF_CMD([opus],[./autogen.sh;  ./configure])
