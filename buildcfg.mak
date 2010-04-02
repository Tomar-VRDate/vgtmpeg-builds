#build types:
# native
# win32

ifeq ($(NBUILD_TYPE),win32)
	export NBUILD_TYPE=win32
else
	export NBUILD_TYPE=native
endif


prefix=$(PWD)/$(NBUILD_TYPE)/build
srcdir=$(PWD)/$(NBUILD_TYPE)/src
build=`gcc -dumpmachine`


ifeq ($(NBUILD_TYPE),win32)
	CONFIGURE_BASE_OPT=--host=i586-mingw32msvc --build=$(build) --prefix=$(prefix)
	export CC=i586-mingw32msvc-gcc
	export AR=i586-mingw32msvc-ar
	export RANLIB=i586-mingw32msvc-ranlib
	export LD=i586-mingw32msvc-ld
	export PKG_CONFIG_LIBDIR=${prefix}/lib/pkgconfig/
	export PKG_CONFIG_PATH=${PKG_CONFIG_LIBDIR}
	export CONFIG_SITE=$(pwd)/config.site
	export CFLAGS=-g -O2 -I${prefix}/include -D_WIN32_WINNT=0x0501
	export CXXFLAGS=-g -O2 -I${prefix}/include
	export LDFLAGS=-L${prefix}/lib
else
	CONFIGURE_BASE_OPT= --prefix=$(prefix)
	export PKG_CONFIG_LIBDIR=${prefix}/lib/pkgconfig/
	export PKG_CONFIG_PATH=${PKG_CONFIG_LIBDIR}
	export CFLAGS=-g -O2 -I${prefix}/include 
	export CXXFLAGS=-g -O2 -I${prefix}/include
	export LDFLAGS=-L${prefix}/lib
endif

