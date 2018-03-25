LIBVPX_CONFIGURE_BASE_OPT = --prefix=$(prefix) --as=yasm --disable-unit-tests --disable-examples --disable-docs --disable-webm-io --disable-libyuv --disable-shared
LIBVPX_VERSION = v1.7.0

ifeq ($(buildtype),linux-x86_64)
	LIBVPX_CONFIGURE_BASE_OPT +=  --target=x86_64-linux-gcc
endif

ifeq ($(buildtype),linux-x86_32)
	LIBVPX_CONFIGURE_BASE_OPT +=  --target=x86-linux-gcc
endif

ifeq ($(buildtype),windows-x86_32)
	LIBVPX_CONFIGURE_BASE_OPT +=  --target=x86-win32-gcc --as=yasm
endif

ifeq ($(buildtype),windows-x86_64)
	LIBVPX_CONFIGURE_BASE_OPT +=  --target=x86_64-win64-gcc
endif

ifeq ($(buildtype),darwin-x86_32)
	LIBVPX_CONFIGURE_BASE_OPT +=  --target=x86-darwin9-gcc
endif

ifeq ($(buildtype),darwin-x86_64)
	LIBVPX_CONFIGURE_BASE_OPT +=  --target=x86_64-darwin9-gcc
endif

DEFMOD([libvpx], [$(LIBVPX_VERSION)],[libvpx-vgtmpeg],[git], [$(NL_GIT_BASE)],,[])
DEFMOD_COPT([libvpx],[$(LIBVPX_CONFIGURE_BASE_OPT)])

#platform depending environment tweaks
# libvpx gets confused with mingw32 ld and adds -m32 to it that makes it barf. this seems to work
DEFMOD_TOOLSET([libvpx],[LD],[$(COMMON_CC)])
