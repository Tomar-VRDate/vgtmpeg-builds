LAME_VERSION = master
LAME_BASE = BB_GIT_BASE
LAME_SRC_BASE = faac
LAME_GET_TYPE = git
LAME_COPT =  $(CONFIGURE_BASE_OPT) --without-mp4v2

DEFMOD([faac],[$(LAME_VERSION)],[$(LAME_SRC_BASE)],[$(LAME_GET_TYPE)],[$(BB_GIT_BASE)],[$(LAME_COPT)])
DEFMOD_CONF_CMD([faac],[echo timestamp > stamp-h.in 2> /dev/null; ./configure])

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



