# https://repology.org/project/usbredir
# https://git.alpinelinux.org/aports/tree/main/usbredir/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/usbredir/usbredir.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/usbredir/template

pkg_ver  := 0.8.0
pkg_repo := https://gitlab.freedesktop.org/spice/usbredir
pkg_site := https://www.spice-space.org/download/usbredir
pkg_deps := libusb

pkg_configure := LIBUSB_LIBS="-lusb-1.0 -ludev" $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sbindir=/usr/bin \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--disable-shared \
	--without-pic

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
