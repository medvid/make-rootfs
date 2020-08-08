pkg_ver  := 3320300
pkg_site := https://www.sqlite.org/2020
pkg_base := sqlite-autoconf
pkg_deps := libedit

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-shared \
	--enable-editline \
	--disable-dynamic-extensions \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
