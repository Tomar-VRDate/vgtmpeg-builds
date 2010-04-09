#build types:
# native
# win32

ifeq ($(NBUILD_TYPE),win32)
	export NBUILD_TYPE=win32
else
	export NBUILD_TYPE=native
endif



include buildcfg.mak 

include devel.pkgcfg
include m4test.pkgmak


#support for config target
CCOPT=$($(module)_copt)
ifdef ccopt
CCOPT += $(ccopt)
endif

MYBUILD = $(foreach lib,$(PKG), $(lib).build)

#test: 
#:w echo $(MYBUILD)

dobuild: $(MYBUILD)

.SECONDEXPANSION:
%.build: %_get$$($$*_gettype)
	set -e; \
	cd $(srcdir); \
	cd $($*_basedir); \
	$(MAKE); \
	$(MAKE) install; \
	cd ..;

%_gettar: makesrcdir
	set -e; \
	cd $(srcdir); \
	base=$*-$($*_version); \
	tar=$$base.tar.gz; \
	src=$($*_loc)/$$tar;\
	if [ ! -f $$base/Makefile ]; then \
	wget -nc $$src; \
	rm -rf $$base; \
	tar -xzvf $$tar; \
	cd $$base; \
	./configure $($*_copt); \
	cd ..; \
	fi; \
	cd ..;

%_getgit: makesrcdir
	set -e; \
	cd $(srcdir); \
	name=$($*_basedir); \
	if [ ! -f $$name/Makefile ]; then \
	rm -rf $$name; \
	git clone $($*_loc)/$$name; \
	cd $$name; \
	git checkout $($*_version); \
	./autogen.sh -- $($*_copt); \
	cd ..; \
	fi; \
	cd ..; 

%_make:
	set -e; \
	cd $(srcdir)/$($*_basedir); \
	$(MAKE); \
	cd ../..;

%_install:
	set -e; \
	cd $(srcdir)/$($*_basedir); \
	$(MAKE) install; \
	cd ../..;

%_config: 
	set -e; \
	cd $(srcdir)/$($*_basedir); \
	if [ $($*_gettype) == tar ]; then \
	./configure $(CCOPT) $($*_copt); \
	else \
	./autogen.sh -- $(CCOPT) $($*_copt) ; \
	fi; \
	cd ../..;

makesrcdir:
	test -d $(srcdir) || mkdir -p $(srcdir);

reset:
	rm -rf $(NBUILD_TYPE)

%.pkgmak: %.m4
	m4 $*.m4 > $*.pkgmak

donothing:

