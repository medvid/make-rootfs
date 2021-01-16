# https://repology.org/project/valgrind
# https://git.alpinelinux.org/aports/tree/main/valgrind/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/valgrind/valgrind.mk
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/valgrind/template

pkg_ver  := 3.16.1
pkg_repo := https://sourceware.org/git/valgrind.git
pkg_site := https://sourceware.org/pub/valgrind

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--enable-lto

pkg_build := make

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
