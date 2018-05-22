VGTMPEG_CONFIGURE_BASE_OPT = --prefix=$(prefix) --enable-doc --pkg-config-flags="--static" --pkg-config="pkg-config" --disable-shared --enable-static  

dnl 64bits

ifeq ($(buildtype),linux-x86_64)
	VGTMPEG_CONFIGURE_BASE_OPT += --enable-pthreads --arch=x86_64 --extra-libs=-lpthread --extra-libs=-ldl --extra-libs="-static" 
endif


ifeq ($(buildtype),windows-x86_64)
	VGTMPEG_CONFIGURE_BASE_OPT +=  --extra-cflags="-DPTW32_STATIC_LIB -static-libgcc -static-libstdc++ -static -O3 -s" --extra-ldflags="-static-libgcc -static-libstdc++ -static" --arch=x86_64 --enable-cross-compile --target-os=mingw32 --cross-prefix=$(tools_prefix)  --extra-cflags="-static" 
dnl    export LIBX264_OPT_LIBS= -lpthreadGC2 
endif


ifeq ($(buildtype),darwin-x86_64)
	VGTMPEG_CONFIGURE_BASE_OPT +=  --enable-pthreads  --arch=x86_64
endif






dnl 32bits

ifeq ($(buildtype),linux-x86_32)
	VGTMPEG_CONFIGURE_BASE_OPT += --enable-pthreads --arch=x86_32 --enable-cross-compile --target-os=linux --extra-libs=-lpthread --extra-libs=-ldl

endif

ifeq ($(buildtype),windows-x86_32)
    dnl DPTW32_STATIC_LIB  is needed because it triggers some protocol in pthreads.h (w32) to initialize this on windows
	VGTMPEG_CONFIGURE_BASE_OPT +=  --extra-cflags="-DPTW32_STATIC_LIB -static-libgcc -static-libstdc++ -static -O3 -s" --extra-ldflags="-static-libgcc -static-libstdc++ -static"   --arch=i386 --enable-cross-compile --target-os=mingw32 --cross-prefix=$(tools_prefix) 
dnl    export LIBX264_OPT_LIBS= -lpthreadGC2 
endif


ifeq ($(buildtype),darwin-x86_32)
	VGTMPEG_CONFIGURE_BASE_OPT +=  --enable-pthreads --arch=i386
endif



DEFMOD([vgtmpeg],[master], [vgtmpeg], [git], [$(BB_GIT_BASE)] )
DEFMOD_COPT([vgtmpeg],[$(VGTMPEG_CONFIGURE_BASE_OPT)])
