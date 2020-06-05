pkg_ver  := 1.0.3
pkg_repo := https://git.code.sf.net/p/libuuid/code
pkg_site := http://prdownloads.sourceforge.net/libuuid

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--disable-silent-rules \
	--disable-shared \
	--without-pic

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
