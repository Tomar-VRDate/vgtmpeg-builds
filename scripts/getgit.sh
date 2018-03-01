#!/bin/sh
# parameters $base_url, $srcdir, $gitname, $gitver, $cachedir

base_url=$1  #the root of the git repos
srcdir=$2   #the root of the sources for this build, not including this project
gitname=$3  #the name of the git repo
gitver=$4   #version to checkout after clone
cachedir=$5 #temporary directory where to clone first

set -x 
set -e; 
test -d $cachedir || mkdir $cachedir
cd $cachedir
rm -rf $gitname;
mkdir $gitname;
cd $gitname;

git clone ${base_url}${gitname}
cd $gitname
git checkout $gitver
cd ..


#finally move untarred ball onto dest
cp -aRf $gitname $srcdir
