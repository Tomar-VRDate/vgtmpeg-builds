#!/bin/sh
# parameters $base_url, $tar_name, $srcdir, $basedir, $cachedir

base_url=$1
tar_file=$2
srcdir=$3
basedir=$4
cachedir=$5

set -x 
set -e; 
test -d $cachedir || mkdir $cachedir

if [ ! -d $srcdir/$basedir ]; then
cd $( readlink -f $cachedir); 
rm -rf $basedir;
mkdir -p $basedir/tar;
cd $basedir;

src=$base_url/$tar_file;
wget -nc $src; 
tar -xzvf $tar_file -C tar 
cd tar
#run post get if any
if [ -f postget.sh ]; then
    ./postget.sh;
fi

#finally move untarred ball onto dest
mv $basedir $srcdir
cd ..;
cd ..;

fi

