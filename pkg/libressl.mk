pkg_ver  := 3.2.1
pkg_repo := https://github.com/libressl-portable/portable
pkg_site := https://ftp.openbsd.org/pub/OpenBSD/LibreSSL

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-silent-rules \
	--disable-shared \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR) && \
	rm -f $(OUT_DIR)/usr/bin/ocspcheck
