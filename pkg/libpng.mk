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

# Skip installation of useless programs (libpng-config, png-fix-itxt, pngfix)
pkg_install := make install-data install-libLTLIBRARIES DESTDIR=$(OUT_DIR)
