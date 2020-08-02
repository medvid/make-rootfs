pkg_ver  := 1.6.37
pkg_repo := https://git.code.sf.net/p/libpng/code
pkg_site := http://prdownloads.sourceforge.net/libpng
pkg_deps := zlib

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-silent-rules \
	--disable-shared \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR) && rm -f \
	$(OUT_DIR)/usr/bin/libpng16-config \
	$(OUT_DIR)/usr/bin/libpng-config \
	$(OUT_DIR)/usr/bin/png-fix-itxt \
	$(OUT_DIR)/usr/bin/pngfix
