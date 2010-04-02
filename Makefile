#build types:
# native
# win32

ifeq ($(NBUILD_TYPE),win32)
	export NBUILD_TYPE=win32
else
	export NBUILD_TYPE=native
endif



include buildcfg.mak packages.mak


#support for config target
CCOPT=$($(MODULE)_copt)
ifdef ccopt
CCOPT += $(ccopt)
endif

MYBUILD = $(foreach lib,$(PKG), $(lib).build)

#test: 
#:w echo $(MYBUILD)

dobuild: $(MYBUILD)

.SECONDEXPANSION:
%.build: %_$$($$*_gettype)
	set -e; \
	cd $(srcdir); \
	cd $($*_basedir); \
	$(MAKE); \
	$(MAKE) install; \
	cd ..;


%_tar: makesrcdir
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

%_git: makesrcdir
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

config: 
ifdef MODULE
	set -e; \
	cd $(srcdir)/$($(MODULE)_basedir); \
	./configure $(CCOPT); \
	cd ../..;
else
	@echo "MODULE='module' not specified on command line"
endif

makesrcdir:
	test -d $(srcdir) || mkdir -p $(srcdir);

reset:
	rm -rf $(NBUILD_TYPE)