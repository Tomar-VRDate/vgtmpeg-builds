#build types:
# native
# win32

include buildcfg.mak 

include devel.pkgcfg


#support for config target
CCOPT=$($(module)_copt)
ifdef ccopt
CCOPT += $(ccopt)
endif

MYBUILD = $(foreach lib,$(PKG), $(lib)_build)

#test: 
#:w echo $(MYBUILD)

dobuild: $(MYBUILD)

.SECONDEXPANSION:
%_build: %_get %_forceconfig %_make %_install
	@echo "build succesful"

%_get: makesrcdir
	$($*_getcmd)

%_clean:
	set -e; \
	cd $(srcdir)/$($*_basedir); \
	$($*_makecmd) clean; \
	cd ../..;

%_make:
	set -e; \
	cd $(srcdir)/$($*_basedir); \
	$($*_makecmd); \
	cd ../..;

%_install:
	set -e; \
	cd $(srcdir)/$($*_basedir); \
	$($*_makecmd) install; \
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
	rm -rf $(buildtype)

%.pkgcfg: %.m4 defmod.m4 gstcommon.m4
	m4 $*.m4 > $*.pkgcfg

donothing:

