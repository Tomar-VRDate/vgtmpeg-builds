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
%.build: %_get$$($$*_gettype) %_forceconfig %_make %_install
	echo "build succesful"


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

%_delete:
	rm -rf $(srcdir)/$($*_basedir); 

%_config: 
	set -e; \
	cd $(srcdir)/$($*_basedir); \
	if [ ! -f Makefile ]; then \
	$($*_confcmd) $(CCOPT) $($*_copt); \
	fi; \
	cd ../..;

%_forceconfig:
	set -e; \
	cd $(srcdir)/$($*_basedir); \
	$($*_confcmd) $(CCOPT) $($*_copt); \
	cd ../..;

tags:
	find . -name "*.[ch]" | xargs ctags -a;

makesrcdir:
	test -d $(srcdir) || mkdir -p $(srcdir);

delete:
	rm -rf $(NBUILD_TYPE)

%.pkgcfg: %.m4 defmod.m4 gstcommon.m4
	m4 $*.m4 > $*.pkgcfg

donothing:

