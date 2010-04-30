include(`defmod.m4')


RESOURCE_URL_BASE=http://nelalabs.com/res
GITREPO_BASE=git@nelalabs.unfuddle.com:nelalabs/
SVN_BASE=--username svnuser --password 19761976 http://nelalabs.com/svn/nelapackages
NL_GIT_BASE=ngit@nelalabs.com:

DEFMOD_DEFAULT_COPT( [$(CONFIGURE_BASE_OPT)] )

    
DEFMOD([zlib], [1.2.4],, [svn], [$(SVN_BASE)], [--prefix=${prefix}] )
ifeq ($(buildtype),win32)
	DEFMOD_COPT_ADD( [zlib], [--uname=MINGW] )
    DEFMOD_MAKECMD([zlib], [$(MAKE) -f win32/Makefile.gcc])
    DEFMOD_INSTCMD([zlib], [$(MAKE) -f win32/Makefile.gcc install])
endif

DEFMOD([libiconv], [1.13.1],, [tar], [$(RESOURCE_URL_BASE)])
DEFMOD([libogg], [1.2.0],, [svn], [$(SVN_BASE)])
DEFMOD([libvorbis], [1.3.1],, [svn], [$(SVN_BASE)])
DEFMOD([faac], [1.28],, [svn], [$(SVN_BASE)],,[--without-mp4v2])
DEFMOD([gettext], [0.17],, [tar], [$(RESOURCE_URL_BASE)])
DEFMOD_COPT_ADD([gettext], [--disable-csharp --without-emacs --disable-java --disable-native-java] )

DEFMOD([pkg_config], [0.23],[pkg-config-0.23], [svn], [$(SVN_BASE)])
DEFMOD([glib], [2.22.5],, [svn], [$(SVN_BASE)])
DEFMOD([libxml2], [2.7.7],, [tar], [$(RESOURCE_URL_BASE)],,[--without-python])
DEFMOD([liboil], [0.3.17],, [tar], [$(RESOURCE_URL_BASE)],,[--disable-glib --disable-gtk-doc], [./autogen.sh])

DEFMOD([gstreamer], [RELEASE-0.10.28], [gstreamer], [git], [$(GITREPO_BASE)],,,[./autogen.sh --] )
DEFMOD_COPT_ADD([gstreamer], [--enable-gtk-doc=no --disable-loadsave --disable-examples --disable-tests --disable-check --disable-net] )

DEFMOD([gst_plugins_base], [RELEASE-0.10.28], [gst-plugins-base], [git], [$(GITREPO_BASE)],,[--enable-gtk-doc=no], [./autogen.sh --]  )
DEFMOD([gst_plugins_good], [RELEASE-0.10.21], [gst-plugins-good], [git], [$(GITREPO_BASE)],,[--enable-gtk-doc=no --disable-shout2], [./autogen.sh --] )
DEFMOD([gst_plugins_bad], [RELEASE-0.10.18], [gst-plugins-bad], [git], [$(GITREPO_BASE)],, [--enable-gtk-doc=no --with-plugins=qtmux --disable-acm], [./autogen.sh --] )
DEFMOD([gst_plugins_ugly], [RELEASE-0.10.14], [gst-plugins-ugly], [git], [$(GITREPO_BASE)],, [--enable-gtk-doc=no --with-plugins=asfdemux], [./autogen.sh --] )
DEFMOD([gst_ffmpeg], [NELA_RELEASE-0.0.5], [gst-ffmpeg], [git], [$(GITREPO_BASE)],,,[./autogen.sh --] )
DEFMOD([encodebin], [RELEASE-0.0.3], [encodebin], [git], [$(GITREPO_BASE)],,,[./autogen.sh --] )
DEFMOD([gmt_transcode], [RELEASE-0.0.1], [gmt-transcode], [git], [$(GITREPO_BASE)],,,[./autogen.sh --] )

DEFMOD([gmt_dist], [HEAD], [gst_dist_builder], [git], [$(NL_GIT_BASE)],,,[echo] )
DEFMOD_MAKECMD([gmt_dist],[GSTDISTCMD([gmt_dist])])
DEFMOD_INSTCMD([gmt_dist],[:])


dnl defaults here
GSTREAMER_PKGS = gstreamer gst_plugins_base gst_plugins_good gst_plugins_bad gst_plugins_ugly gst_ffmpeg
PKG= gettext glib liboil zlib libogg libvorbis faac $(GSTREAMER_PKGS) encodebin gmt_transcode

dnl per target configs
ifeq ($(buildtype),win32)
PKG= libiconv gettext glib liboil zlib libogg libvorbis faac $(GSTREAMER_PKGS) encodebin gmt_transcode gmt_dist
endif

ifeq ($(buildtype),darwin)
PKG= gettext pkg_config glib liboil zlib libogg libvorbis faac $(GSTREAMER_PKGS) encodebin gmt_transcode gmt_dist
endif


