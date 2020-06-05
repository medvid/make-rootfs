pkg_ver  := 1.2.11
pkg_repo := https://github.com/madler/zlib
pkg_site := https://www.zlib.net

pkg_configure := $(pkg_srcdir)/configure \
	--prefix=/usr \
	--static

pkg_build := make libz.a

pkg_install := make install DESTDIR=$(OUT_DIR)
