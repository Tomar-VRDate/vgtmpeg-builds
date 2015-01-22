#build types:
# native
# win32


builddef ?= default

include $(builddef).pkgcfg



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

%_get: prereq
	$($*_getcmd)

%_clean:
	set -e; \
	cd $(srcdir)/$($*_build_basedir); \
	$($*_makecmd) clean; \
	cd ../..;

%_make: prereq %_tools
	set -e; \
	cd $(srcdir)/$($*_build_basedir); \
	$($*_makecmd); \
	cd ../..;

%_install: %_tools
	set -e; \
	cd $(srcdir)/$($*_build_basedir); \
	$($*_instcmd); \
	cd ../..;

%_delete:
	if [ ! "$($*_basedir)" = "" ]; then \
	rm -rf $(srcdir)/$($*_basedir); \
	fi;

%_config: %_tools
	set -e; \
	cd $(srcdir)/$($*_build_basedir); \
	if [ ! -f Makefile ]; then \
	$($*_confcmd) $(CCOPT) $($*_copt); \
	fi; \
	cd ../..;

%_forceconfig: %_tools
	set -e; \
	cd $(srcdir)/$($*_build_basedir); \
	$($*_confcmd) $(CCOPT) $($*_copt); \
	cd ../..;

%_tools:
	$(eval $(call $*_set_tools)) 
	env
	

tags:
	find . -name "*.[ch]" | xargs ctags -a;

prereq:
	set -x; \
	test -d log || mkdir log ;\
	test -d $(srcdir) || mkdir -p $(srcdir); \
	#perl -e 'die "\n\n\n/bin/sh doesnt seem to point to bash. bash is required." if (`/bin/sh --version` !~ /bash/)';


delete:
	rm -rf $(buildbasedir)

%.pkgcfg: builddefs/%.m4 common builddefs
	m4 builddefs/$*.m4 > $*.pkgcfg

donothing:

