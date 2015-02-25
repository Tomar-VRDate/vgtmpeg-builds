X265_CONFIGURE_BASE_OPT = $(CONFIGURE_BASE_OPT)  



DEFMOD([x265], [1.5],[x265],[git], [$(NL_GIT_BASE)],,[])
DEFMOD_MAKECMD([x265], [cd build/linux; $(MAKE)])
DEFMOD_INSTCMD([x265], [cd build/linux; $(MAKE) install])

CMAKE_DEFS += -DCMAKE_INSTALL_PREFIX:PATH=$(prefix) 
CMAKE_DEFS += -DCMAKE_C_COMPILER=$(CC)
CMAKE_DEFS += -DCMAKE_CXX_COMPILER=$(CXX)
CMAKE_DEFS += -DCMAKE_SHARED_LIBRARY_LINK_C_FLAGS=""
CMAKE_DEFS += -DCMAKE_SHARED_LIBRARY_LINK_CPP_FLAGS=""
CMAKE_DEFS += -DENABLE_SHARED:BOOL=OFF -DENABLE_CLI:BOOL=ON


ifeq ($(buildtype),linux-x86_64)
	X265_CONFIGURE_BASE_OPT +=  
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -g "Unix Makefiles" ../../source])
endif

ifeq ($(buildtype),linux-x86_32)
	X265_CONFIGURE_BASE_OPT += 
    CMAKE_DEFS += -DCMAKE_C_FLAGS="-static-libgcc -static-libstdc++ -static -O3 -s -m32"
    CMAKE_DEFS += -DCMAKE_CPP_FLAGS="-static-libgcc -static-libstdc++ -static -O3 -s -m32"
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -DCMAKE_CXX_COMPILER:STRING=$(CXX) -g "Unix Makefiles" ../../source])
endif

ifeq ($(buildtype),windows-x86_32)
	X265_CONFIGURE_BASE_OPT +=  
    CMAKE_DEFS += -DCMAKE_SYSTEM_NAME:STRING=Windows 
    CMAKE_DEFS += -DCMAKE_CXX_FLAGS="-static-libgcc -static-libstdc++ -static -O3 -s"
    CMAKE_DEFS += -DCMAKE_C_FLAGS="-static-libgcc -static-libstdc++ -static -O3 -s"
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -g "Windows32 Makefiles" ../../source])
endif

ifeq ($(buildtype),windows-x86_64)
	X265_CONFIGURE_BASE_OPT += 

    CMAKE_DEFS += -DCMAKE_SYSTEM_NAME:STRING=Windows 
    CMAKE_DEFS += -DCMAKE_CXX_FLAGS="-static-libgcc -static-libstdc++ -static -O3 -s"
    CMAKE_DEFS += -DCMAKE_C_FLAGS="-static-libgcc -static-libstdc++ -static -O3 -s"
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -g "Windows64 Makefiles" ../../source])
endif

ifeq ($(buildtype),darwin-x86_32)
	X265_CONFIGURE_BASE_OPT += 
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS) -DCMAKE_OSX_ARCHITECTURES:STRING=i386 -DENABLE_ASSEMBLY:BOOL=ON  -g "Unix Makefiles" ../../source])
endif

ifeq ($(buildtype),darwin-x86_64)
	X265_CONFIGURE_BASE_OPT += 
    DEFMOD_CONF_CMD([x265], [cd build/linux; cmake $(CMAKE_DEFS)  -DCMAKE_OSX_ARCHITECTURES:STRING=x86_64 -g "Unix Makefiles" ../../source])
endif
DEFMOD_COPT([x265],[ ])
