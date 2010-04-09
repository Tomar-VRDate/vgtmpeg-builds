define(`LVER', `$1_version=$2') dnl
define(`LBASEDIR', `$1_basedir=$2') dnl
define(`LGETTYPE', `$1_gettype=$2') dnl
define(`LLOC',     `$1_loc=$2') dnl
define(`LCOPT',    `$1_copt=$2') dnl

define(`DEFMOD', `LVER($1,$2)
LBASEDIR($1,$3)
LGETTYPE($1,$4)
LLOC($1,$5)
LCOPT($1,$6)
' ) dnl


DEFMOD(`liboil', `RELEASE-0.1.1', `basedir', `tar', `$(GITREPO_BASE)', `--options')
