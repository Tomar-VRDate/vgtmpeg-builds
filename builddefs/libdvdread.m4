LIBDVDREAD_VERSION = master
LIBDVDREAD_BASE = BB_GIT_BASE
LIBDVDREAD_SRC_BASE = libdvdread-vgtmpeg
LIBDVDREAD_GET_TYPE = git
LIBDVDREAD_COPT =  $(CONFIGURE_BASE_OPT) --enable-shared --enable-static 

ifeq ($(buildtype),linux-x86_64)
endif

ifeq ($(buildtype),linux-x86_32)
endif

ifeq ($(buildtype),windows-x86_32)
endif

ifeq ($(buildtype),windows-x86_64)
endif

ifeq ($(buildtype),darwin-x86_32)
endif

ifeq ($(buildtype),darwin-x86_64)
endif


DEFMOD([libdvdread],[$(LIBDVDREAD_VERSION)],[$(LIBDVDREAD_SRC_BASE)],[$(LIBDVDREAD_GET_TYPE)],[$(BB_GIT_BASE)],[$(LIBDVDREAD_COPT)])

