# https://repology.org/project/less
# https://git.alpinelinux.org/aports/tree/main/less/APKBUILD
# https://git.buildroot.net/buildroot/tree/package/less/less.mk
# https://github.com/distr1/distri/blob/master/pkgs/less/build.textproto
# https://github.com/kisslinux/community/blob/master/community/less/build
# https://github.com/void-linux/void-packages/blob/master/srcpkgs/less/template

pkg_ver  := 563
pkg_repo := https://github.com/gwsw/less
pkg_site := http://www.greenwoodsoftware.com/less
pkg_deps := ncurses

pkg_configure := $(pkg_srcdir)/configure \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--with-secure \
	--with-regex=posix

pkg_build := make

pkg_install := make install DESTDIR=$(OUT_DIR)
