# https://repology.org/project/sqlite
# https://git.alpinelinux.org/aports/tree/main/sqlite/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/sqlite/sqlite.mk
# https://github.com/distr1/distri/blob/master/pkgs/sqlite3/build.textproto
# https://github.com/kisslinux/repo/blob/master/extra/sqlite/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/sqlite/template

pkg_ver  := 3340100
pkg_site := https://www.sqlite.org/2021
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

pkg_check := make check

pkg_install := make install DESTDIR=$(OUT_DIR)
