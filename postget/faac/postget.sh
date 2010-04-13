#!/bin/bash

SCRIPTDIR=$(dirname $(readlink -f $0));
echo $SCRIPTDIR

# this is supposed to be run on the top of faac sources
echo patching Makefile.am to enable mingw32 dll creation
patch -p0 -N --verbose < $SCRIPTDIR/Makefile.am.patch

echo creating autogen.sh for configuration
tool_run ()
{
  tool=$1
  options=$2
  run_if_fail=$3
  echo "+ running $tool $options..."
  $tool $options || {
    echo
    echo $tool failed
    exit 1
  }
}

tool_run "libtoolize" "--copy --force"
tool_run "autoheader"
tool_run "aclocal" 
# touch the stamp-h.in build stamp so we don't re-run autoheader in maintainer mode -- wingo
echo timestamp > stamp-h.in 2> /dev/null
tool_run "automake" "--add-missing --copy"
tool_run "autoconf"

echo done faac postget
