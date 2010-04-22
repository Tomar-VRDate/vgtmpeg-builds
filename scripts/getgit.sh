#!/bin/sh
# parameters $base_url, $srcdir, $gitname, $gitver, $cachedir

base_url=$1
srcdir=$2
gitname=$3
gitver=$4
cachedir=$5

set -x 
set -e; 
test -d $cachedir || mkdir $cachedir
cd $( readlink -f $cachedir); 
rm -rf $gitname;
mkdir $gitname;
cd $gitname;

git clone $base_url/$gitname
cd $gitname
git checkout $gitver
cd ..


#finally move untarred ball onto dest
cp -rf $gitname $srcdir
cd ..;
cd ..;
