LIBVPX_CONFIGURE_BASE_OPT = --prefix=$(prefix)

ifeq ($(buildtype),linux-x86_64)
	LIBVPX_CONFIGURE_BASE_OPT = --prefix=$(prefix) --target=x86_64-linux-gcc
endif

ifeq ($(buildtype),linux-x86_32)
	LIBVPX_CONFIGURE_BASE_OPT = --prefix=$(prefix) --target=x86-linux-gcc
endif

ifeq ($(buildtype),windows-x86_32)
    export CROSS=i586-mingw32msvc-
    export LD=
	LIBVPX_CONFIGURE_BASE_OPT = --prefix=$(prefix) --target=x86-win32-gcc --as=yasm
endif

ifeq ($(buildtype),windows-x86_64)
	LIBVPX_CONFIGURE_BASE_OPT = --prefix=$(prefix) --target=x86_64-win64-gcc
endif

ifeq ($(buildtype),darwin-x86_32)
	LIBVPX_CONFIGURE_BASE_OPT = --prefix=$(prefix) --target=x86-darwin9-gcc
endif

ifeq ($(buildtype),darwin-x86_64)
	LIBVPX_CONFIGURE_BASE_OPT =  --prefix=$(prefix) --target=x86_64-darwin9-gcc
endif

DEFMOD([libvpx], [v0.9.6],[libvpx],[git], [$(NL_GIT_BASE)projects/],,[])
DEFMOD_COPT([libvpx],[$(LIBVPX_CONFIGURE_BASE_OPT)])
