# https://repology.org/project/slibtool
# https://git.alpinelinux.org/aports/tree/community/slibtool/APKBUILD

pkg_ver  := 0.5.31
pkg_repo := https://dev.midipix.org/cross/slibtool
pkg_site := http://midipix.org/dl/slibtool

pkg_configure := $(pkg_srcdir)/configure \
	--compiler=$(CC) \
	--prefix=/usr \
	--all-static \
	--disable-app

pkg_build := make static

pkg_install := make install-static DESTDIR=$(OUT_DIR)
