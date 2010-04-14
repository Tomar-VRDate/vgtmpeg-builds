include(`defmod.m4')


RESOURCE_URL_BASE=http://nelalabs.com/res
GITREPO_BASE=git@nelalabs.unfuddle.com:nelalabs
SVN_BASE=--username alberto --password 00z4swxu svn://guarida.dyndns.org/nelapackages

DEFMOD_DEFAULT_COPT( [$(CONFIGURE_BASE_OPT)] )

    
DEFMOD([zlib], [1.2.4],, [svn], [$(SVN_BASE)], [--prefix=${prefix}] )
ifeq ($(buildtype),win32)
	DEFMOD_COPT_ADD( [zlib], [--uname=MINGW] )
    DEFMOD_MAKECMD([zlib], [$(MAKE) -f win32/Makefile.gcc])
endif

DEFMOD([libogg], [1.1.4],, [tar], [$(RESOURCE_URL_BASE)])
DEFMOD([libvorbis], [1.2.3],, [tar], [$(RESOURCE_URL_BASE)],,,[./autogen.sh ])
DEFMOD([libiconv], [1.13.1],, [tar], [$(RESOURCE_URL_BASE)])
DEFMOD([faac], [1.28],, [tar], [$(RESOURCE_URL_BASE)],,[--without-mp4v2])
DEFMOD([gettext], [0.17],, [tar], [$(RESOURCE_URL_BASE)])
DEFMOD([glib], [2.22.5],, [tar], [$(RESOURCE_URL_BASE)],,,[./autogen.sh] )
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


GSTREAMER_PKGS = gstreamer gst_plugins_base gst_plugins_good gst_plugins_bad gst_plugins_ugly gst_ffmpeg
ifeq ($(buildtype),win32)
PKG= libiconv gettext glib liboil zlib libogg libvorbis faac $(GSTREAMER_PKGS) encodebin gmt_transcode
else
PKG= gettext glib liboil zlib libogg libvorbis faac $(GSTREAMER_PKGS) encodebin gmt_transcode
endif


