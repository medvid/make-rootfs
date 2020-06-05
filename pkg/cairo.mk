pkg_ver  := 1.17.2
pkg_repo := https://gitlab.freedesktop.org/cairo/cairo
pkg_site := https://cairographics.org/snapshots
pkg_deps := pixman freetype fontconfig

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-silent-rules \
	--disable-shared \
	--disable-valgrind \
	--disable-xlib \
	--disable-xlib-xrender \
	--disable-xcb \
	--disable-xlib-xcb \
	--disable-xcb-shm \
	--disable-qt \
	--disable-drm \
	--disable-png \
	--disable-egl \
	--disable-glx \
	--disable-script \
	--enable-ft \
	--enable-fc \
	--disable-ps \
	--disable-pdf \
	--disable-svg \
	--disable-ps \
	--disable-gobject \
	--without-pic \
	ax_cv_c_float_words_bigendian=no

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
