FDKAAC_VERSION = master
FDKAAC_BASE = GH_GIT_BASE
FDKAAC_SRC_BASE = fdk-aac
FDKAAC_GET_TYPE = git
FDKAAC_COPT =  $(CONFIGURE_BASE_OPT) --disable-shared 

DEFMOD([fdk-aac],[$(FDKAAC_VERSION)],[$(FDKAAC_SRC_BASE)],[$(FDKAAC_GET_TYPE)],[$(GH_GIT_BASE)],[$(FDKAAC_COPT)])
DEFMOD_CONF_CMD([fdk-aac],[./autogen.sh;  ./configure])

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



