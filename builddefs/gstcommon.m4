include(`common/defmod.m4')
include([common/buildcfg.mak])


RESOURCE_URL_BASE=http://nelalabs.com/res
SVN_BASE=--username svnuser --password 19761976 http://nelalabs.com/svn/nelapackages
NL_GIT_BASE=ngit@nelalabs.com:
NL_GIT_BASE_GST=ngit@nelalabs.com:gstreamer/
NL_GIT_BASE_LIBS=$(NL_GIT_BASE)libs/
BB_GIT_BASE=git@bitbucket.org:concalma/
dnl overrides for bb git hosting
NL_GIT_BASE=$(BB_GIT_BASE)
NL_GIT_BASE_GST=$(BB_GIT_BASE)
NL_GIT_BASE_LIBS=$(BB_GIT_BASE)

DEFMOD_DEFAULT_COPT( [$(CONFIGURE_BASE_OPT)] )

    
DEFMOD([zlib], [1.2.4],, [svn], [$(SVN_BASE)], [--prefix=${prefix}] )
ifeq ($(buildtype),windows-x86_32)
	DEFMOD_COPT_ADD( [zlib], [--uname=MINGW] )
    DEFMOD_MAKECMD([zlib], [$(MAKE) -f win32/Makefile.gcc])
    DEFMOD_INSTCMD([zlib], [$(MAKE) -f win32/Makefile.gcc install])
endif

DEFMOD([libiconv], [1.13.1],, [tar], [$(RESOURCE_URL_BASE)])
dnl DEFMOD([libogg], [1.2.0],, [svn], [$(SVN_BASE)])
dnl DEFMOD([libvorbis], [1.3.1],, [svn], [$(SVN_BASE)])

DEFMOD([libogg], [1.3.0],[libogg], [git],    [$(NL_GIT_BASE_LIBS)],,[--disable-shared])
DEFMOD([libvorbis], [1.3.2],[libvorbis], [git], [$(NL_GIT_BASE_LIBS)],,[--disable-shared]) 

dnl DEFMOD([faac], [1.28],[faac], [git], [$(NL_GIT_BASE)],,[--without-mp4v2])
DEFMOD([gettext], [0.18.1.1],, [svn], [$(SVN_BASE)])
DEFMOD_COPT_ADD([gettext], [--disable-csharp --without-emacs --disable-java --disable-native-java] )

DEFMOD([pkg_config], [0.23],[pkg-config-0.23], [svn], [$(SVN_BASE)])
DEFMOD([glib], [2.22.5],, [svn], [$(SVN_BASE)])
DEFMOD([libxml2], [2.7.7],, [tar], [$(RESOURCE_URL_BASE)],,[--without-python])
DEFMOD([liboil], [0.3.17],, [tar], [$(RESOURCE_URL_BASE)],,[--disable-glib --disable-gtk-doc])

DEFMOD([gstreamer], [NLRELEASE-0.10.28_NOEXAMPLES], [gstreamer], [git], [$(NL_GIT_BASE_GST)],,,[./autogen.sh --] )
DEFMOD_COPT_ADD([gstreamer], [--enable-gtk-doc=no --disable-loadsave --disable-examples --disable-tests --disable-check --disable-net] )

dnl DEFMOD_COPT_ADD([x264], [--enable-shared --enable-pic])

DEFMOD([gst_plugins_base], [NLRELEASE-0.10.28], [gst-plugins-base], [git], [$(NL_GIT_BASE_GST)],,[--enable-gtk-doc=no], [./autogen.sh --]  )
DEFMOD([gst_plugins_good], [RELEASE-0.10.21], [gst-plugins-good], [git], [$(NL_GIT_BASE_GST)],,[--enable-gtk-doc=no --disable-shout2], [./autogen.sh --] )
DEFMOD([gst_plugins_bad], [RELEASE-0.10.18], [gst-plugins-bad], [git], [$(NL_GIT_BASE_GST)],, [--enable-gtk-doc=no --with-plugins=qtmux --disable-acm], [./autogen.sh --] )
DEFMOD([gst_plugins_ugly], [RELEASE-0.10.14], [gst-plugins-ugly], [git], [$(NL_GIT_BASE_GST)],, [--enable-gtk-doc=no --with-plugins=asfdemux], [./autogen.sh --] )
DEFMOD([gst_ffmpeg], [NELA_RELEASE-0.0.5], [gst-ffmpeg], [git], [$(NL_GIT_BASE_GST)],,,[./autogen.sh --noconfigure; ./configure ] )
DEFMOD([nltrans], [RELEASE-0.0.3], [nltrans], [git], [$(NL_GIT_BASE_GST)],,,[./autogen.sh --] )
DEFMOD([gmt_transcode], [RELEASE-0.0.1], [gmt-transcode], [git], [$(NL_GIT_BASE_GST)],,,[./autogen.sh --] )

DEFMOD([gmt_dist], [HEAD], [gst_dist_builder], [git], [$(NL_GIT_BASE)],,,[./autogen.sh] )
DEFMOD_MAKECMD([gmt_dist],[GSTDISTCMD([gmt_dist])])
DEFMOD_INSTCMD([gmt_dist],[:])

DEFMOD([ffmpeg],[0.5.2],,[svn],[$(SVN_BASE)])

dnl defaults here
GSTREAMER_PKGS = gstreamer gst_plugins_base gst_plugins_good gst_plugins_bad gst_plugins_ugly gst_ffmpeg
PKG= gettext glib liboil zlib libogg libvorbis faac $(GSTREAMER_PKGS) nltrans gmt_transcode gmt_dist

dnl per target configs
ifeq ($(buildtype),windows-x86_32)
PKG= libiconv gettext glib liboil zlib libogg libvorbis faac $(GSTREAMER_PKGS) nltrans gmt_transcode gmt_dist
endif

ifeq ($(build_os),darwin)
PKG= gettext glib liboil zlib libogg libvorbis faac $(GSTREAMER_PKGS) nltrans gmt_transcode gmt_dist
endif


