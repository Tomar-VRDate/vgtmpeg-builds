#build types:
# native
# win32

ifeq ($(NBUILD_TYPE),win32)
	export NBUILD_TYPE=win32
else
	export NBUILD_TYPE=native
endif



include buildcfg.mak packages.mak


MYBUILD = $(foreach lib,$(PKG), $(lib).build)

#test: 
#:w echo $(MYBUILD)

dobuild: $(MYBUILD)

.SECONDEXPANSION:
%.build: %_$$($$*_gettype)
	cd $(srcdir); \
	cd $($*_basedir); \
	$(MAKE); \
	$(MAKE) install; \
	cd ..;


%_tar: makesrcdir
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
	cd $(srcdir); \
	name=$($*_basedir); \
	if [ ! -f $$name/Makefile ]; then \
	rm -rf $$name; \
	git clone $($*_loc)/$$name; \
	cd $$name; \
	git checkout $($*_version); \
	./autogen.sh $($*_opt); \
	cd ..; \
	fi; \
	cd ..; 


makesrcdir:
	test -d $(srcdir) || mkdir -p $(srcdir);

reset:
	rm -rf $(NBUILD_TYPE)
