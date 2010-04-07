#build types:
# as defined in $(NBUILD_TYPE)
# native
# win32

RESOURCE_URL_BASE=http://nelalabs.com/res
GITREPO_BASE=git@nelalabs.unfuddle.com:nelalabs

zlib_version=1.2.4
zlib_gettype=tar
zlib_basedir=zlib-$(zlib_version)
zlib_loc=$(RESOURCE_URL_BASE)
ifeq ($(NBUILD_TYPE),win32)
	zlib_copt=--prefix=${prefix} --uname=MINGW
else
	zlib_copt=--prefix=${prefix} 
endif


libogg_version=1.1.4
libogg_basedir=libogg-$(libogg_version)
libogg_gettype=tar
libogg_loc=$(RESOURCE_URL_BASE)
libogg_copt=$(CONFIGURE_BASE_OPT)

libiconv_version=1.13.1
libiconv_basedir=libiconv-$(libiconv_version)
libiconv_gettype=tar
libiconv_loc=$(RESOURCE_URL_BASE)
libiconv_copt=$(CONFIGURE_BASE_OPT)

libvorbis_version=1.2.3
libvorbis_basedir=libvorbis-$(libvorbis_version)
libvorbis_gettype=tar
libvorbis_loc=$(RESOURCE_URL_BASE)
libvorbis_copt=$(CONFIGURE_BASE_OPT)

gettext_version=0.17
gettext_basedir=gettext-$(gettext_version)
gettext_gettype=tar
gettext_loc=$(RESOURCE_URL_BASE)
gettext_copt=$(CONFIGURE_BASE_OPT) 

glib_version=2.22.5
glib_basedir=glib-$(glib_version)
glib_gettype=tar
glib_loc=$(RESOURCE_URL_BASE)
glib_copt=$(CONFIGURE_BASE_OPT)

libxml2_version=2.7.7
libxml2_basedir=libxml2-$(libxml2_version)
libxml2_gettype=tar
libxml2_loc=$(RESOURCE_URL_BASE)
libxml2_copt=$(CONFIGURE_BASE_OPT) --without-python

liboil_version=0.3.17
liboil_basedir=liboil-$(liboil_version)
liboil_gettype=tar
liboil_loc=$(RESOURCE_URL_BASE)
liboil_copt=$(CONFIGURE_BASE_OPT)

gstreamer_version=RELEASE-0.10.28
gstreamer_basedir=gstreamer
gstreamer_gettype=git
gstreamer_loc=$(GITREPO_BASE)
gstreamer_copt=$(CONFIGURE_BASE_OPT) --enable-gtk-doc=no --disable-loadsave --disable-examples --disable-tests --disable-check --disable-net

gst_plugins_base_version=RELEASE-0.10.28
gst_plugins_base_basedir=gst-plugins-base
gst_plugins_base_gettype=git
gst_plugins_base_loc=$(GITREPO_BASE)
gst_plugins_base_copt=$(CONFIGURE_BASE_OPT) --enable-gtk-doc=no

gst_plugins_good_version=RELEASE-0.10.21
gst_plugins_good_basedir=gst-plugins-good
gst_plugins_good_gettype=git
gst_plugins_good_loc=$(GITREPO_BASE)
gst_plugins_good_copt=$(CONFIGURE_BASE_OPT) --enable-gtk-doc=no --disable-shout2

gst_plugins_bad_version=RELEASE-0.10.18
gst_plugins_bad_basedir=gst-plugins-bad
gst_plugins_bad_gettype=git
gst_plugins_bad_loc=$(GITREPO_BASE)
gst_plugins_bad_copt=$(CONFIGURE_BASE_OPT) --enable-gtk-doc=no  --with-plugins=qtmux

gst_ffmpeg_version=NELA_RELEASE-0.0.3
gst_ffmpeg_basedir=gst-ffmpeg
gst_ffmpeg_gettype=git
gst_ffmpeg_loc=$(GITREPO_BASE)
gst_ffmpeg_copt=$(CONFIGURE_BASE_OPT) 

encodebin_version=RELEASE-0.0.3
encodebin_basedir=encodebin
encodebin_gettype=git
encodebin_loc=$(GITREPO_BASE)
encodebin_copt=$(CONFIGURE_BASE_OPT) 

gmt_transcode_version=RELEASE-0.0.1
gmt_transcode_basedir=gmt-transcode
gmt_transcode_gettype=git
gmt_transcode_loc=$(GITREPO_BASE)
gmt_transcode_copt=$(CONFIGURE_BASE_OPT) 

ifeq ($(NBUILD_TYPE),win32)
PKG= libiconv gettext glib liboil zlib libogg libvorbis gstreamer gst_plugins_base gst_plugins_good gst_plugins_bad gst_ffmpeg encodebin gmt_transcode
else
PKG= gettext glib liboil zlib libogg libvorbis gstreamer gst_plugins_base gst_plugins_good gst_plugins_bad gst_ffmpeg encodebin gmt_transcode
endif
