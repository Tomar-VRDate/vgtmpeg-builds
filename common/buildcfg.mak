#build types:
# native
# win32

ifdef debug
	coptflags = -g3 -O0 
else
	coptflags = -g -O3 
endif

ifeq ($(buildtype),linux-x86_64)
	export build_os=linux
	export build_arch=x86_64
endif

ifeq ($(buildtype),linux-x86_32)
	export build_os=linux
	export build_arch=x86_32
endif

ifeq ($(buildtype),windows-x86_32)
	export build_os=windows
	export build_arch=x86_32
endif

ifeq ($(buildtype),windows-x86_64)
	export build_os=windows
	export build_arch=x86_64
endif

ifeq ($(buildtype),darwin-x86_64)
	export build_os=darwin
	export build_arch=x86_64
endif

ifeq ($(buildtype),darwin-x86_32)
	export build_os=darwin
	export build_arch=x86_32
endif

topdir=$(shell pwd)
buildbasedir=$(topdir)/${builddef}/$(buildtype)
distdir=$(buildbasedir)/dist
prefix=$(buildbasedir)/build
srcdir=$(buildbasedir)/src
build=`gcc -dumpmachine`


#ifeq ($(buildtype),windows-x86_32)
#	CONFIGURE_BASE_OPT=--host=i586-mingw32msvc --build=$(build) --prefix=$(prefix)
#	export CC=i586-mingw32msvc-gcc
#	export AR=i586-mingw32msvc-ar
#	export AS=i586-mingw32msvc-as
#	export RC=i586-mingw32msvc-windres
#	export STRIP=i586-mingw32msvc-strip
#	export RANLIB=i586-mingw32msvc-ranlib
#	export LD=i586-mingw32msvc-ld
#	export PKG_CONFIG_LIBDIR=${prefix}/lib/pkgconfig/
#	export PKG_CONFIG_PATH=${PKG_CONFIG_LIBDIR}
#	export CONFIG_SITE=$(pwd)/config.site
#	export CFLAGS= ${coptflags} -I${prefix}/include -D_WIN32_WINNT=0x0501
#	export CXXFLAGS= ${coptflags}  -I${prefix}/include
#	export LDFLAGS=-L${prefix}/lib
#	export INCLUDE_PATH=${prefix}/include
#	export LIBRARY_PATH=${prefix}/lib
#	export BIN_PATH=${prefix}/bin
#else
#	CONFIGURE_BASE_OPT= --prefix=$(prefix)
#	export PKG_CONFIG_LIBDIR=${prefix}/lib/pkgconfig/
#	export PKG_CONFIG_PATH=${PKG_CONFIG_LIBDIR}
#	export CFLAGS= ${coptflags}  -I${prefix}/include 
#	export CXXFLAGS= ${coptflags}  -I${prefix}/include
#	export LDFLAGS=-L${prefix}/lib
#	export INCLUDE_PATH=${prefix}/include
#	export BIN_PATH=${prefix}/bin
#	export LIBRARY_PATH=${prefix}/lib
#	export PATH:=$(BIN_PATH):$(PATH)
#endif

LINKTOOL=ld

ifeq ($(buildtype),windows-x86_32)
	host=i686-w64-mingw32
	tools_prefix=$(host)-
	CFLAGS_ADD= -D_WIN32_WINNT=0x0501
	LINKTOOL=ld
else
	host=x86_64-w64-mingw32
	tools_prefix=$(host)-
	LINKTOOL=ld
endif

ifeq ($(buildtype),linux-x86_32)
	tools_prefix=
	host=i386-linux-gnu
	CFLAGS_ADD=  -m32 -msse -msse2
	LDFLAGS_ADD=  -m32
endif

ifeq ($(buildtype),linux-x86_64)
	tools_prefix=
	host=x86_64-linux-gnu
	CFLAGS_ADD = -m64
	LDFLAGS_ADD = -m64
endif

ifeq ($(buildtype),darwin-x86_32)
	tools_prefix=
	host=i386-apple-darwin10
	CFLAGS_ADD = -arch i386
	LDFLAGS_ADD = -arch i386
endif

ifeq ($(buildtype),darwin-x86_64)
	tools_prefix=
	host=x86_64-apple-darwin10
	CFLAGS_ADD =  -arch x86_64
	LDFLAGS_ADD = -arch x86_64
endif

#common exports across platforms
CONFIGURE_BASE_OPT= --prefix=$(prefix) --build=$(build) --host=$(host)

COMMON_PKG_CONFIG_LIBDIR=${prefix}/lib/pkgconfig/
COMMON_PKG_CONFIG_PATH=${PKG_CONFIG_LIBDIR}
COMMON_CFLAGS= ${coptflags}  -I${prefix}/include  $(CFLAGS_ADD)
COMMON_CXXFLAGS= ${coptflags}  -I${prefix}/include $(CFLAGS_ADD)
COMMON_LDFLAGS=-L${prefix}/lib $(LDFLAGS_ADD)
COMMON_INCLUDE_PATH=${prefix}/include
COMMON_BIN_PATH=${prefix}/bin
COMMON_LIBRARY_PATH=${prefix}/lib
COMMON_PATH:=$(COMMON_BIN_PATH):$(PATH)
COMMON_CROSS=$(tools_prefix)

#set tools
COMMON_CC=$(tools_prefix)gcc
COMMON_AR=$(tools_prefix)ar
COMMON_AS=$(tools_prefix)as
COMMON_RC=$(tools_prefix)windres
COMMON_STRIP=$(tools_prefix)strip
COMMON_RANLIB=$(tools_prefix)ranlib
COMMON_LD=$(tools_prefix)$(LINKTOOL)

