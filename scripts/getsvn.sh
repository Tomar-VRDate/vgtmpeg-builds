#!/bin/sh
# parameters $base_url, $srcdir, $svnname, $svnver, $cachedir

base_url=$1
srcdir=$2
svnname=$3
svnver=$4
cachedir=$5

set -x 
set -e; 
test -d $cachedir || mkdir $cachedir
cd $cachedir
rm -rf $svnname;

svn checkout $base_url/$svnname
cd $svnname
#run post get if any
if [ -f postget.sh ]; then
    ./postget.sh;
fi

#finally move untarred ball onto dest
cp -aRf $svnname $srcdir
