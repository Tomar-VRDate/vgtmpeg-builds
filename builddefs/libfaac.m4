FAAC_VERSION = master
FAAC_BASE = BB_GIT_BASE
FAAC_SRC_BASE = faac-vgtmpeg
FAAC_GET_TYPE = git
FAAC_COPT =  $(CONFIGURE_BASE_OPT) --without-mp4v2

DEFMOD([faac],[$(FAAC_VERSION)],[$(FAAC_SRC_BASE)],[$(FAAC_GET_TYPE)],[$(BB_GIT_BASE)],[$(FAAC_COPT)])
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



