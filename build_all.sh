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
glib_version=2.16.3
libxml2_version=2.6.32
libiconv_version=1.13.1
gettext_version=0.17

prefix=$(pwd)/build
srcdir=$(pwd)/src

RESOURCE_URL_BASE=http://nelalabs.com/res


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

#LIBICONV
libiconv_base=libiconv-$libiconv_version
libiconv_tar=$libiconv_base.tar.gz
libiconv_src=$RESOURCE_URL_BASE/$libiconv_tar
if [ ! -f $libiconv_tar ]
then
    wget $libiconv_src
    rm -rf $libiconv_base
    tar -xzvf $libiconv_tar
    cd $libiconv_base
    ./configure \
    --host=i586-mingw32msvc \
    --build=i486-linux-gnu \
    --prefix=$prefix
    make
    make install
    cd ..
fi

#GETTEXT
gettext_base=gettext-$gettext_version
gettext_tar=$gettext_base.mingw32patched.tar.gz
gettext_src=$RESOURCE_URL_BASE/$gettext_tar
if [ ! -f $gettext_tar ]
then
    wget $gettext_src
    rm -rf $gettext_base
    tar -xzvf $gettext_tar
    cd $gettext_base
    ./configure \
    --host=i586-mingw32msvc \
    --build=i486-linux-gnu \
    --prefix=$prefix
    make
    make install
    cd ..
fi


#return to origin
cd ..
