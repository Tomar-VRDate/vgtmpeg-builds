XVID_VERSION = master
XVID_BASE = BB_GIT_BASE
XVID_SRC_BASE = xvid
XVID_BUILD_BASE_DIR = xvid/build/generic
XVID_GET_TYPE = git
XVID_COPT =  $(CONFIGURE_BASE_OPT) 

DEFMOD([xvid],[$(XVID_VERSION)],[$(XVID_SRC_BASE)],[$(XVID_GET_TYPE)],[$(BB_GIT_BASE)],[$(XVID_COPT)])
DEFMOD_BUILD_BASEDIR([xvid],[$(XVID_BUILD_BASE_DIR]))
dnl DEFMOD_CONF_CMD([xvid],[$(XVID_BUILD_BASE)/configure])

define([DEFMOD_MAKECMD], [$1_makecmd=$2]) dnl
define([DEFMOD_INSTCMD], [$1_instcmd=$2]) dnl
ifeq ($(buildtype),linux-x86_64)
endif

ifeq ($(buildtype),linux-x86_32)
endif

ifeq ($(buildtype),windows-x86_32)
    DEFMOD_COPT_ADD([xvid],[--disable-pthread])
dnl    DEFMOD_MAKECMD([xvid],[$(MAKE) xvidcore.a])
dnl    DEFMOD_INSTCMD([xvid],[install -m 644 =build/xvidcore.a $(prefix)/lib/libxvidcore.a; install -m 644 ../../src/xvid.h $(prefix)/include/xvid.h])    
endif

ifeq ($(buildtype),windows-x86_64)
    DEFMOD_COPT_ADD([xvid],[--disable-pthread])
dnl    DEFMOD_MAKECMD([xvid],[$(MAKE) xvidcore.a])
dnl    DEFMOD_INSTCMD([xvid],[install -m 644 =build/xvidcore.a $(prefix)/lib/libxvidcore.a; install -m 644 ../../src/xvid.h $(prefix)/include/xvid.h])    
endif

ifeq ($(buildtype),darwin-x86_32)
endif

ifeq ($(buildtype),darwin-x86_64)
endif



