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
liboil_version=0.3.17
libvorbis_version=1.2.3
libogg_version=1.1.4
zlib_version=1.2.4
gettext_version=0.17
#gstreamer_git_tagname=NELARELEASE-0.0.1
gstreamer_git_tagname=RELEASE-0.10.28
gstbase_tag=RELEASE-0.10.28
gstgood_tag=RELEASE-0.10.21
gstffmpeg_tag=NELA_RELEASE-0.0.3
encbin_tag=RELEASE-0.0.1
gmttranscode_tag=RELEASE-0.0.1

prefix=$(pwd)/build
srcdir=$(pwd)/src
build=`gcc -dumpmachine`

RESOURCE_URL_BASE=http://nelalabs.com/res
GITREPO_BASE=git@nelalabs.unfuddle.com:nelalabs
CONFIGURE_BASE_OPT="--host=i586-mingw32msvc --build=$build --prefix=$prefix "

export CC=i586-mingw32msvc-gcc
export AR=i586-mingw32msvc-ar
export RANLIB=i586-mingw32msvc-ranlib
export LD=i586-mingw32msvc-ld
export PKG_CONFIG_LIBDIR=${prefix}/lib/pkgconfig/
export PKG_CONFIG_PATH=$PKG_CONFIG_LIBDIR
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
function tar_get_and_build {
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

#git_get_and_build
# $1 library_name
# $2 library_tag_name
# $3 configure options
function git_get_and_build {
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

tar_get_and_build     libiconv   $libiconv_version      "$CONFIGURE_BASE_OPT"
tar_get_and_build     gettext    $gettext_version       "$CONFIGURE_BASE_OPT"
tar_get_and_build     glib       $glib_version          "$CONFIGURE_BASE_OPT"
tar_get_and_build     libxml2    $libxml2_version       "$CONFIGURE_BASE_OPT --without-python" 
tar_get_and_build     liboil     $liboil_version        "$CONFIGURE_BASE_OPT" 
tar_get_and_build     zlib       $zlib_version          "--prefix=$prefix --static --uname=MINGW" 
#tar_get_and_build     libogg     $libogg_version        "$CONFIGURE_BASE_OPT" 
#tar_get_and_build     libvorbis  $libvorbis_version     "$CONFIGURE_BASE_OPT" 
git_get_and_build gstreamer  $gstreamer_git_tagname "$CONFIGURE_BASE_OPT --enable-gtk-doc=no"
git_get_and_build gst-plugins-base  $gstbase_tag    "$CONFIGURE_BASE_OPT --enable-gtk-doc=no --disable-ogg --disable-vorbis"
git_get_and_build gst-plugins-good  $gstgood_tag    "$CONFIGURE_BASE_OPT --enable-gtk-doc=no --disable-shout2"
git_get_and_build gst-ffmpeg      $gstffmpeg_tag    "$CONFIGURE_BASE_OPT --disable-silent-rules" 
git_get_and_build encodebin       $encbin_tag       "$CONFIGURE_BASE_OPT" 
git_get_and_build gmt-transcode   $gmttranscode_tag "$CONFIGURE_BASE_OPT" 


#return to origin
cd ..
