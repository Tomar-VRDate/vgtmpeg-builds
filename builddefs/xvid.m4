XVID_VERSION = master
XVID_BASE = BB_GIT_BASE
XVID_SRC_BASE = xvid
XVID_BUILD_BASE_DIR = xvid/build/generic
XVID_GET_TYPE = git
XVID_COPT =  $(CONFIGURE_BASE_OPT) 
XVID_STATIC_LIB = 

ifeq ($(build_os),windows)
    XVID_STATIC_LIB = xvidcore.a
else
    XVID_STATIC_LIB = libxvidcore.a
endif

DEFMOD([xvid],[$(XVID_VERSION)],[$(XVID_SRC_BASE)],[$(XVID_GET_TYPE)],[$(BB_GIT_BASE)],[$(XVID_COPT)])
DEFMOD_BUILD_BASEDIR([xvid],[$(XVID_BUILD_BASE_DIR]))
DEFMOD_MAKECMD([xvid],[$(MAKE) $(XVID_STATIC_LIB)])
DEFMOD_INSTCMD([xvid],[mkdir -p $(prefix)/lib; mkdir -p $(prefix)/bin; install -m 644 =build/$(XVID_STATIC_LIB) $(prefix)/lib/; install -m 644 ../../src/xvid.h $(prefix)/include/xvid.h])    

ifeq ($(buildtype),linux-x86_64)
endif

ifeq ($(buildtype),linux-x86_32)
endif

ifeq ($(buildtype),windows-x86_32)
    DEFMOD_COPT_ADD([xvid],[--disable-pthread])
endif

ifeq ($(buildtype),windows-x86_64)
    DEFMOD_COPT_ADD([xvid],[--disable-pthread])
endif

ifeq ($(buildtype),darwin-x86_32)
endif

ifeq ($(buildtype),darwin-x86_64)
endif



