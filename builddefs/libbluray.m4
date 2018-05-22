LIBBLURAY_VERSION = master
LIBBLURAY_BASE = BB_GIT_BASE
LIBBLURAY_SRC_BASE = libbluray-vgtmpeg
LIBBLURAY_GET_TYPE = git
LIBBLURAY_COPT =  $(CONFIGURE_BASE_OPT) --disable-shared --enable-static --without-libxml2 --without-freetype --disable-examples --disable-bdjava-jar

DEFMOD([libbluray],[$(LIBBLURAY_VERSION)],[$(LIBBLURAY_SRC_BASE)],[$(LIBBLURAY_GET_TYPE)],[$(BB_GIT_BASE)],[$(LIBBLURAY_COPT)])
DEFMOD_CONF_CMD([libbluray],[git submodule update --init; ./bootstrap; ./configure])

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



