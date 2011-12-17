LIBVPX_CONFIGURE_BASE_OPT = --prefix=$(prefix) --as=yasm 
LIBVPX_VERSION = v0.9.7-nl

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
    LIBVPX_VERSION=v0.9.7-p1
endif

ifeq ($(buildtype),darwin-x86_64)
	LIBVPX_CONFIGURE_BASE_OPT +=  --target=x86_64-darwin9-gcc
    LIBVPX_VERSION=v0.9.7-p1
endif

DEFMOD([libvpx], [$(LIBVPX_VERSION)],[libvpx],[git], [$(NL_GIT_BASE)projects/],,[])
DEFMOD_COPT([libvpx],[$(LIBVPX_CONFIGURE_BASE_OPT)])

#platform depending environment tweaks
# libvpx gets confused with mingw32 ld and adds -m32 to it that makes it barf. this seems to work
DEFMOD_TOOLSET([libvpx],[LD],[$(COMMON_CC)])
