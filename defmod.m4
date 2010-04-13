changequote([,])dnl

#define([TARCMD], [[set -e; \
#	cd $(srcdir); \
#	base=$1-$($1_version); \
#	tar=$$base.tar.gz; \
#	src=$($1_loc)/$$tar;\
#	if [[ ! -f $$base/Makefile ]]; then \
#	wget -nc $$src; \
#	rm -rf $$base; \
#	tar -xzvf $$tar; \
#	fi; \
#	cd ..; ]] ) dnl
#
#
#
#define([GITCMD], [set -e; \
#	cd $(srcdir); \
#	name=$($1_basedir); \
#	if [ ! -f $$name/Makefile ]; then \
#	rm -rf $$name; \
#	git clone $($1_loc)/$$name; \
#	cd $$name; \
#	git checkout $($1_version); \
#	cd ..; \
#	fi; \
#	cd ..; 

define([DEFMOD_VER], [$1_version=$2]) dnl
define([DEFMOD_BASEDIR], [ifelse( [], [$2], [$1_basedir=$1-$($1_version)], [$1_basedir=$2])] ) dnl
define([DEFMOD_GETTYPE], [$1_gettype=$2]) dnl
define([DEFMOD_LOC],     [$1_loc=$2]) dnl
define([DEFMOD_COPT],    [ifelse( [], [$2], [$1_copt=$(default_copt)], [$1_copt=$2])] ) dnl
define([DEFMOD_COPT_ADD],    [$1_copt+=  $2]) dnl
define([DEFMOD_CONF_CMD],    [ifelse( [], [$2], [$1_confcmd=./configure], [$1_confcmd=$2])] ) dnl
define([DEFMOD_DEFAULT_COPT], [default_copt=$1] ) dnl
define([DEFMOD_GETCMD], [ifelse( [tar], [$2], [$1_getcmd=TARCMD($1)], [$1_getcmd=GITCMD($1)] )]) dnl

dnl DEFMOD ( libname, version, [basedir], type, url, [copt_default], [copt_extra] )
define([DEFMOD], [DEFMOD_VER($1,$2)
DEFMOD_BASEDIR($1,$3)
DEFMOD_GETTYPE($1,$4)
DEFMOD_LOC($1,$5)
DEFMOD_COPT($1,$6)
DEFMOD_COPT_ADD($1,$7)
DEFMOD_CONF_CMD($1,$8)
DEFMOD_GETCMD($1,$4)
] ) dnl




