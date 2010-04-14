changequote([,])dnl

define([TARCMD], [scripts/gettar.sh $($1_loc) $($1_basedir).tar.gz $(srcdir) $($1_basedir) $(buildtype)/cache]) dnl
define([GITCMD], [scripts/getgit.sh $($1_loc) $(srcdir) $($1_basedir) $($1_version) $(buildtype)/cache]) dnl
define([SVNCMD], [scripts/getsvn.sh "$($1_loc)" "$(srcdir)" "$($1_basedir)" "$($1_version)" "$(buildtype)/cache]") dnl



define([DEFMOD_VER], [$1_version=$2]) dnl
define([DEFMOD_BASEDIR], [ifelse( [], [$2], [$1_basedir=$1-$($1_version)], [$1_basedir=$2])]) dnl
define([DEFMOD_GETTYPE], [$1_gettype=$2]) dnl
define([DEFMOD_LOC],     [$1_loc=$2]) dnl
define([DEFMOD_COPT],    [ifelse( [], [$2], [$1_copt=$(default_copt)], [$1_copt=$2])] ) dnl
define([DEFMOD_COPT_ADD],    [$1_copt+=  $2]) dnl
define([DEFMOD_CONF_CMD],    [ifelse( [], [$2], [$1_confcmd=./configure], [$1_confcmd=$2])] ) dnl
define([DEFMOD_DEFAULT_COPT], [default_copt=$1] ) dnl
define([DEFMOD_GETCMD], [ifelse( [tar], [$2], [$1_getcmd=TARCMD($1)], [svn], [$2], [$1_getcmd=SVNCMD($1)], [$1_getcmd=GITCMD($1)] )]) dnl
define([DEFMOD_MAKECMD], [$1_makecmd=$2]) dnl

dnl DEFMOD ( libname, version, [basedir], type, url, [copt_default], [copt_extra] )
define([DEFMOD], [DEFMOD_VER($1,$2)
DEFMOD_BASEDIR($1,$3)
DEFMOD_GETTYPE($1,$4)
DEFMOD_LOC($1,$5)
DEFMOD_COPT($1,$6)
DEFMOD_COPT_ADD($1,$7)
DEFMOD_CONF_CMD($1,$8)
DEFMOD_GETCMD($1,$4)
DEFMOD_MAKECMD($1,$(MAKE))
] ) dnl




