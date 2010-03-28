#!/bin/sh

set -e

rebuild=no

gst_version=0.10.25
gstpb_version=0.10.25
gstpg_version=0.10.17
gstpu_version=0.10.13
gstpbad_version=0.10.17
gnonlin_version=0.10.9
gstpy_version=0.10.12
glib_version=2.22.5
libxml2_version=2.7.7
libiconv_version=1.13.1
gettext_version=0.17
#gstreamer_git_tagname=NELARELEASE-0.0.1
gstreamer_git_tagname=RELEASE-0.10.28

prefix=$(pwd)/build
srcdir=$(pwd)/src

RESOURCE_URL_BASE=http://nelalabs.com/res
GITREPO_BASE=git@nelalabs.unfuddle.com:nelalabs
CONFIGURE_BASE_OPT="--host=i586-mingw32msvc \
        --prefix=$prefix "
#        --build=i486-linux-gnu \

export CC=i586-mingw32msvc-gcc
export LD=i586-mingw32msvc-ld
export PKG_CONFIG_LIBDIR=${prefix}/lib/pkgconfig/
export PKG_CONFIG_PATH=
export CONFIG_SITE=$(pwd)/config.site

if [ $rebuild = yes ]
then
rm -rf $prefix
rm -rf $srcdir
fi


export CFLAGS="-g -O2 -I${prefix}/include -D_WIN32_WINNT=0x0501"
export CXXFLAGS="-g -O2 -I${prefix}/include"
export LDFLAGS="-L${prefix}/lib"

#we start here
test -d $srcdir || mkdir $srcdir
cd $srcdir

#get_and_build
# $1 library_name
# $2 library_version
# $3 configure extra options
function get_and_build {
    base=$1-$2
    tar=$base.tar.gz
    src=$RESOURCE_URL_BASE/$tar
    copt=$3

    if [ ! -f $tar ]
    then
        wget $src
        rm -rf $base
        tar -xzvf $tar
        cd $base
        ./configure $copt 
        make
        make install
        cd ..
    fi
}

#gst_get_and_build
# $1 library_name
# $2 library_tag_name
# $3 configure options
function gst_get_and_build {
    name=$1
    tagname=$2
    copt=$3
    if [ ! -d $name ]
    then
        rm -rf $name
        git clone $GITREPO_BASE/$name
        cd $name
        git checkout $tagname
        ./autogen.sh -- $copt 
        make
        make install
        cd ..
    fi
}

get_and_build     libiconv   $libiconv_version      "$CONFIGURE_BASE_OPT"
get_and_build     gettext    $gettext_version       "$CONFIGURE_BASE_OPT"
get_and_build     glib       $glib_version          "$CONFIGURE_BASE_OPT"
get_and_build     libxml2    $libxml2_version       "$CONFIGURE_BASE_OPT --without-python" 
gst_get_and_build gstreamer  $gstreamer_git_tagname "$CONFIGURE_BASE_OPT --enable-gtk-doc=no"


#return to origin
cd ..
