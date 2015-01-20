X265_CONFIGURE_BASE_OPT = $(CONFIGURE_BASE_OPT)  



DEFMOD([x265], [HEAD],[x265],[git], [$(NL_GIT_BASE)],,[])
DEFMOD_MAKECMD([x265], [cd build/linux; $(MAKE)])
DEFMOD_INSTCMD([x265], [cd build/linux; $(MAKE) install])

CMAKE_DEFS += -DCMAKE_INSTALL_PREFIX:PATH=$(prefix)

ifeq ($(buildtype),linux-x86_64)
	X265_CONFIGURE_BASE_OPT +=  
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -g "Unix Makefiles" ../../source])
endif

ifeq ($(buildtype),linux-x86_32)
	X265_CONFIGURE_BASE_OPT += 
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -DCMAKE_CXX_COMPILER:STRING=$(CXX) -g "Unix Makefiles" ../../source])
endif

ifeq ($(buildtype),windows-x86_32)
dnl libvpx gets confused with mingw32 ld and adds -m32 to it that makes it barf. this seems to work
dnl    export CROSS=i586-mingw32msvc-
dnl    export LD=
	X265_CONFIGURE_BASE_OPT +=  
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -DCMAKE_SYSTEM_NAME:STRING=Windows -DCMAKE_CXX_COMPILER:STRING=$(CXX) -g "Windows32 Makefiles" ../../source])
endif

ifeq ($(buildtype),windows-x86_64)
	X265_CONFIGURE_BASE_OPT += 
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -DCMAKE_SYSTEM_NAME:STRING=Windows -DCMAKE_CXX_COMPILER:STRING=$(CXX) -g "Windows64 Makefiles" ../../source])
endif

ifeq ($(buildtype),darwin-x86_32)
	X265_CONFIGURE_BASE_OPT += 
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -g "Unix Makefiles" ../../source])
endif

ifeq ($(buildtype),darwin-x86_64)
	X265_CONFIGURE_BASE_OPT += 
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -g "Unix Makefiles" ../../source])
endif
DEFMOD_COPT([x265],[ ])
