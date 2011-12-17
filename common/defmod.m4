changequote([,])dnl

divert([-1])
# foreach(x, (item_1, item_2, ..., item_n), stmt)
#   parenthesized list, simple version
define([foreach], [pushdef([$1])_foreach($@)popdef([$1])])
define([_arg1], [$1])
define([_foreach], [ifelse([$2], [()], [],
  [define([$1], _arg1$2)$3[]$0([$1], (shift$2), [$3])])])
divert[]dnl

define([TARCMD], [scripts/gettar.sh $($1_loc) $($1_basedir).tar.gz $(srcdir) $($1_basedir) $(buildbasedir)/cache]) dnl
define([GITCMD], [scripts/getgit.sh $($1_loc) $(srcdir) $($1_basedir) $($1_version) $(buildbasedir)/cache]) dnl
define([SVNCMD], [scripts/getsvn.sh "$($1_loc)" "$(srcdir)" "$($1_basedir)" "$($1_version)" "$(buildbasedir)/cache]") dnl
define([GSTDISTCMD], [./gst_dist_builder --pars $(topdir)/scripts/gstdist/$1.xml --src_base $(prefix)/../ --dst_base $(distdir)/$2 --dist_type=$(buildtype)] )



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
define([DEFMOD_INSTCMD], [$1_instcmd=$2]) dnl

dnl tools m4 routines
define([DEFMOD_TOOLNAME],[$1_COMMON_$2]) dnl
define([DEFMOD_TOOLDEF],[DEFMOD_TOOLNAME($1,$2)=$(COMMON_$2)
]) dnl


define([DEFMOD_TOOLS_NAMES],  [(PKG_CONFIG_LIBDIR,PKG_CONFIG_PATH,CFLAGS,CXXFLAGS,LDFLAGS,INCLUDE_PATH,BIN_PATH,LIBRARY_PATH,PATH,CC,AR,RC,STRIP,RANLIB,LD,CROSS )]) dnl
define([DEFMOD_TOOLS],[foreach([x], DEFMOD_TOOLS_NAMES , [DEFMOD_TOOLDEF($1,x)]) ]) dnl
define([DEFMOD_TOOLSET],[DEFMOD_TOOLNAME($1,$2)=$3]) dnl
define([DEFMOD_TOOLADD],[DEFMOD_TOOLNAME($1,$2)+=$3]) dnl
define([DEFMOD_TOOLS_EXPORT_B],[foreach([x], DEFMOD_TOOLS_NAMES, [export x = $(DEFMOD_TOOLNAME($1,x))
])]) dnl
define([DEFMOD_TOOLS_EXPORT], [
define $1_set_tools
DEFMOD_TOOLS_EXPORT_B($1)
endef
]) dnl


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
DEFMOD_INSTCMD($1,[$(MAKE) install])
DEFMOD_TOOLS($1)
DEFMOD_TOOLS_EXPORT($1)
] ) dnl



